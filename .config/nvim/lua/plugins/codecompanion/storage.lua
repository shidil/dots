-- checklist/storage.lua
-- Persistent storage for DAG checklists with type annotations

local dag_types = require('plugins.codecompanion.dag_types')
local vim = vim
local M = {}
local json = vim.json or require("vim.json")


local function get_storage_path()
  return "/home/shidil/checklist.json"
end

---@class ChecklistStorage
---@field path string
local ChecklistStorage = {}
ChecklistStorage.__index = ChecklistStorage

---@return ChecklistStorage
function ChecklistStorage.new()
  local self = setmetatable({}, ChecklistStorage)
  self.path = get_storage_path()
  return self
end

---Load checklists and next_id from file
---@return table<integer, DagChecklist>, integer
function ChecklistStorage:load()
  local ok, data = pcall(vim.fn.readfile, self.path)
  if not ok or not data or #data == 0 then
    return {}, 1
  end
  local content = table.concat(data, "\n")
  local ok2, decoded = pcall(json.decode, content)
  if not ok2 or type(decoded) ~= "table" then
    return {}, 1
  end
  ---@type table<integer, DagChecklist>
  local checklists = decoded.checklists or {}
  ---@type integer
  local next_id = decoded.next_id or 1
  return checklists, next_id
end

---Save checklists and next_id to file
---@param checklists table<integer, DagChecklist>
---@param next_id integer
---@return boolean
function ChecklistStorage:save(checklists, next_id)
  local data = {
    checklists = checklists,
    next_id = next_id
  }
  local ok, encoded = pcall(json.encode, data)
  if not ok then
    return false
  end
  local lines = vim.split(encoded, "\n")
  local ok2 = pcall(vim.fn.writefile, lines, self.path)
  return ok2
end

M.new = ChecklistStorage.new

return M
