return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        panel = {
          enabled = false,
        },
        suggestion = {
          enabled = true,
          auto_trigger = false,
          debounce = 100,
          trigger_on_accept = false,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<C-l>",
            prev = false,
            dismiss = false,
          },
        },
        filetypes = {
          yaml = true,
          markdown = true,
        },
        copilot_model = "gpt-4o-copilot",
      })
    end,
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuOpen",
        callback = function()
          vim.b.copilot_suggestion_hidden = true
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "BlinkCmpMenuClose",
        callback = function()
          vim.b.copilot_suggestion_hidden = false
        end,
      })
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false,
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "gpt-4o",             -- your desired model (or use gpt-4o, etc.)
        timeout = 30000,              -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
      provider = "copilot",
      repo_map = {
        ignore_patterns = { "%.git", "%.worktree", "__pycache__", "node_modules" },
      },
      hints = {
        enabled = true,
      },
      copilot = {
        model = "gpt-4.1",
        endpoint = "https://api.githubcopilot.com",
        allow_insecure = false,
        timeout = 10 * 60 * 1000,
        temperature = 0,
        reasoning_effort = "high",
        max_tokens = 100000
      },
      mode = "legacy",
      cursor_applying_provider = 'groq', -- In this example, use Groq for applying, but you can also use any provider you want.
      auto_suggestions_provider = 'copilotsuggest',
      behaviour = {
        auto_suggestions = false,               -- enable auto-suggestions
        auto_suggestions_respect_ignore = true, -- respect ignore patterns
        enable_cursor_planning_mode = true,     -- enable cursor planning mode!
        enable_claude_text_editor_tool_mode = false,
        auto_apply_diff_after_generation = false,
        jump_result_buffer_on_finish = false,
      },
      file_selector = {
        provider = "snacks", -- The provider to use for file selection
      },
      selector = {
        provider = "snacks", -- The provider to use for file selection
      },
      vendors = {
        groq = { -- define groq provider
          __inherited_from = 'openai',
          api_key_name = 'GROQ_API_KEY',
          endpoint = 'https://api.groq.com/openai/v1/',
          model = 'llama-3.3-70b-versatile',
          max_completion_tokens = 32768, -- remember to increase this value, otherwise it will stop generating halfway
        },
        copilotsuggest = {               -- define copilot provider
          __inherited_from = 'copilot',
          model = 'gpt-4o-copilot',
        },
        openrouter = {
          __inherited_from = 'openai',
          endpoint = 'https://openrouter.ai/api/v1',
          api_key_name = 'OPENROUTER_API_KEY',
          model = 'anthropic/claude-3.7-sonnet',
        },
      },
      ollama = {
        model = "llama3.1"
      },
      rag_service = {
        enabled = true,                      -- Enables the RAG service
        host_mount = os.getenv("HOME"),      -- Host mount path for the rag service
        provider = "ollama",                 -- The provider to use for RAG service (e.g. openai or ollama)
        llm_model = "llama3.1",              -- The LLM model to use for RAG service
        embed_model = "nomic-embed-text",    -- The embedding model to use for RAG service
        endpoint = "http://localhost:11434", -- The API endpoint for RAG service
      },
      -- The system_prompt type supports both a string and a function that returns a string. Using a function here allows dynamically updating the prompt with mcphub
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub:get_active_servers_prompt()
      end,
      -- The custom_tools type supports both a list and a function that returns a list. Using a function here prevents requiring mcphub before it's loaded
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
          {
            name = "run_go_tests",                                -- Unique name for the tool
            description = "Run Go unit tests and return results", -- Description shown to AI
            command = "go test -v ./...",                         -- Shell command to execute
            param = {                                             -- Input parameters (optional)
              type = "table",
              fields = {
                {
                  name = "target",
                  description = "Package or directory to test (e.g. './pkg/...' or './internal/pkg')",
                  type = "string",
                  optional = true,
                },
              },
            },
            returns = { -- Expected return values
              {
                name = "result",
                description = "Result of the test run",
                type = "string",
              },
              {
                name = "error",
                description = "Error message if the tests were not successful",
                type = "string",
                optional = true,
              },
            },
            func = function(params, _, _) -- Custom function to execute
              local target = params.target or "./..."
              return vim.fn.system(string.format("go test -v %s", target))
            end,
          },
        }
      end,
      disabled_tools = {
        "list_files",
        "search_files",
        "read_file",
        "create_file",
        "rename_file",
        "delete_file",
        "create_dir",
        "rename_dir",
        "delete_dir",
        "bash",
        "python",
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua",      -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          overrides = {
            filetype = {
              codecompanion = {
                html = {
                  tag = {
                    buf = { icon = " ", highlight = "CodeCompanionChatIcon" },
                    file = { icon = " ", highlight = "CodeCompanionChatIcon" },
                    group = { icon = " ", highlight = "CodeCompanionChatIcon" },
                    help = { icon = "󰘥 ", highlight = "CodeCompanionChatIcon" },
                    image = { icon = " ", highlight = "CodeCompanionChatIcon" },
                    symbols = { icon = " ", highlight = "CodeCompanionChatIcon" },
                    tool = { icon = "󰯠 ", highlight = "CodeCompanionChatIcon" },
                    url = { icon = "󰌹 ", highlight = "CodeCompanionChatIcon" },
                  },
                },
              },
            },
          },
        },
        ft = { "markdown", "codecompanion" },
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    ft = { "markdown", "Avante", "codecompanion" },
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      {
        "ravitemer/mcphub.nvim",
        cmd = "MCPHub",              -- lazy load
        build = "bundled_build.lua", -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
        opts = {
          use_bundled_binary = true, -- Set to true if you want to use the bundled binary instead of the global one
        },
      },
      {
        "Davidyz/VectorCode",
        version = "*", -- optional, depending on whether you're on nightly or release
        dependencies = { "nvim-lua/plenary.nvim" },
        build = "uv tool upgrade vectorcode",
        cmd = "VectorCode", -- if you're lazy-loading VectorCode
      },
      {
        "ravitemer/codecompanion-history.nvim",
      },
      "MeanderingProgrammer/render-markdown.nvim",
    },
    opts = {
      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          }
        },
        history = {
          enabled = true,
          opts = {
            memory = { index_on_startup = true },
          },
        },
        vectorcode = {
          enabled = true,
          opts = {
            tool_group = { extras = { "file_search" }, collapse = true },
            tool_opts = {
              ["*"] = { use_lsp = true },
              ls = {},
              vectorise = {},
              query = {
                default_num = { document = 15, chunks = 100 },
                chunk_mode = true,
                summarise = {
                  enabled = true,
                  system_prompt = function(s)
                    return s
                  end,
                  adapter = function()
                    return require("codecompanion.adapters").extend("copilot", {
                      name = "Summariser",
                      schema = {
                        model = { default = "gemini-2.0-flash" },
                      },
                      opts = { stream = false },
                    })
                  end,
                },
              },
            },
          },
        },
      },
      display = {
        action_palette = {
          provider = "default"
        }
      },
      strategies = {
        chat = {
          keymaps = {
            send = {
              callback = function(chat)
                vim.cmd("stopinsert")
                chat:submit()
              end,
              index = 1,
              description = "Send",
            },
          },
          tools = {
            opts = {
              default_tools = { "vectorcode_toolbox", "read_file" },
              auto_submit_errors = true,  -- Send any errors to the LLM automatically?
              auto_submit_success = true, -- Send any successful output to the LLM automatically?
            },
          },
          opts = {
            prompt_decorator = function(message, adapter, context)
              return string.format([[<prompt>%s</prompt>]], message)
            end,
          }
        },
        inline = {
          adapter = "copilot",
        }
      },
      adapters = {
        copilot = function()
          return require("codecompanion.adapters").extend("copilot", {
            schema = {
              model = {
                default = "gpt-4.1",
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "llama3.1:latest",
              },
              num_ctx = {
                default = 20000,
              },
            },
          })
        end,
      }
    },
    -- https://codecompanion.olimorris.dev/getting-started.html#suggested-plugin-workflow
    keys = {
      {
        "<LocalLeader>A",
        "<cmd>CodeCompanionActions<cr>",
        desc = "Code companion actions",
        mode = { "n", "v" },
      },
      {
        "<LocalLeader>a",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "Code companion chat toggle",
        mode = { "n", "v" }
      },
      {
        "ga",
        "<cmd>CodeCompanionChat Add<cr>",
        desc = "Code companion add to chat",
        mode = { "v" }
      },
      {
        "gp",
        "<cmd>'<,'>CodeCompanion<cr>",
        desc = "Code companion inline assist",
        mode = { "x" }
      },
    },
    config = function(_, opts)
      local spinner = require("plugins.codecompanion.spinner")
      spinner:init()
      require("codecompanion").setup(opts)
      vim.cmd([[cab cc CodeCompanion]])
    end
  },
}
