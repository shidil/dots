-- checklist/dag_executor.lua
-- Handles parallel execution of independent tasks during DAG creation

local M = {}

-- Execute tasks in parallel using the task tool pattern
function M.execute_tasks_parallel(tasks_to_execute, chat, callback)
  if #tasks_to_execute == 0 then
    return callback({})
  end

  local Chat = require("codecompanion.strategies.chat")
  local results = {}
  local completed_count = 0
  local total_count = #tasks_to_execute
  local parent = chat
  local augroups = {}          -- Track all augroups for cleanup
  local backup_timers = {}     -- Track backup timers for cleanup
  local completion_timer = nil -- Debounce timer for completion
  local global_timeout = nil   -- Global timeout timer

  local function cleanup_resources()
    -- Clean up augroups
    for _, aug_id in pairs(augroups) do
      pcall(vim.api.nvim_del_augroup_by_id, aug_id)
    end
    augroups = {}

    -- Clean up backup timers
    for _, timer in pairs(backup_timers) do
      if timer and not timer:is_closing() then
        timer:stop()
        timer:close()
      end
    end
    backup_timers = {}

    -- Clean up global timeout
    if global_timeout and not global_timeout:is_closing() then
      global_timeout:stop()
      global_timeout:close()
      global_timeout = nil
    end
  end

  local function check_completion()
    -- Cancel existing timer if any
    if completion_timer then
      completion_timer:stop()
      completion_timer:close()
      completion_timer = nil
    end

    if completed_count >= total_count then
      -- Use a small delay to ensure all async operations complete
      completion_timer = vim.loop.new_timer()
      completion_timer:start(100, 0, vim.schedule_wrap(function()
        cleanup_resources()
        if completion_timer then
          completion_timer:close()
          completion_timer = nil
        end
        callback(results)
      end))
    end
  end

  -- Execute each task in parallel
  for i, task_info in ipairs(tasks_to_execute) do
    local task_idx = task_info.index
    local task_text = task_info.text

    local system_prompt = [[
You are a fully autonomous agent.

- You cannot interact with a user or ask for clarification.
- You must make all decisions, plan, and execute confidently using any of the available tools.
- You have only one chance to complete the task, so you must keep trying and not end your turn until you have reached a satisfactory result.
- Do not stop or return control until you are confident the task is complete.
]]

    local tools_pref = "@{write} @{edit} @{multiedit} @{read} @{grep} @{list} @{glob} "
        .. "@{checklist_create} @{checklist_status} @{checklist_complete_task} "
        .. "@{webfetch} @{cmd_runner}\n\n"

    local messages = {
      { role = "system", content = system_prompt },
      { role = "user",   content = tools_pref .. task_text }
    }

    local child = Chat.new({
      messages = messages,
      adapter = {
        name = "copilot",
        model = {
          name = "gpt-4.1"
        }
      }
    })

    local id = child.id
    local aug = vim.api.nvim_create_augroup("DagTaskChat_" .. id, { clear = true })
    augroups[task_idx] = aug -- Store augroup for later cleanup

    local function latest_llm_reply(child_chat)
      -- has to have stopped, could have gotten even from another chat
      if child_chat.current_request then
        return nil
      end

      local msgs = child_chat.messages
      for j = #msgs, 1, -1 do
        local m = msgs[j]
        if m.role == "llm" and m.content and m.content ~= "" then
          return m.content
        end
        if m.role == "tool" then
          -- tool arrived but no LLM yet: keep waiting
          return nil
        end
      end
      return nil
    end

    local function try_complete_task()
      local reply = latest_llm_reply(child)
      if not reply then
        return false -- Not ready yet
      end

      -- Double-check we haven't already processed this result
      if results[task_idx] then
        return true -- Already completed
      end

      -- Store the result and increment counter
      results[task_idx] = reply
      completed_count = completed_count + 1

      -- Check if all tasks are complete
      check_completion()
      return true
    end

    -- Create multiple event handlers for better reliability
    vim.api.nvim_create_autocmd("User", {
      group = aug,
      pattern = "CodeCompanionRequestFinished",
      callback = function(ev)
        -- Add small delay to ensure message processing is complete
        vim.defer_fn(function()
          try_complete_task()
        end, 50)
      end,
    })

    -- Backup completion check via timer (in case event is missed)
    local backup_timer = vim.loop.new_timer()
    backup_timers[task_idx] = backup_timer -- Track for cleanup
    backup_timer:start(1000, 1000, vim.schedule_wrap(function()
      if try_complete_task() then
        backup_timer:stop()
        backup_timer:close()
        backup_timers[task_idx] = nil -- Remove from tracking
      end
    end))

    child:submit()
    child.ui:hide()
  end

  -- Global timeout to prevent hanging (60 seconds)
  global_timeout = vim.loop.new_timer()
  global_timeout:start(60000, 0, vim.schedule_wrap(function()
    cleanup_resources()
    -- Return whatever results we have so far
    callback(results)
  end))

  -- If parent UI exists, keep it open
  if parent and parent.ui then
    parent.ui:open({})
  end
end

return M

