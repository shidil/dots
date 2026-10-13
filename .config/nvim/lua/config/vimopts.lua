vim.opt.list           = true  -- Show white space characters
vim.opt.nu             = true  -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.cursorline     = true  -- Highlight line with cursor
vim.opt.scrolloff      = 8     -- Keep 8 lines above and below the cursor
vim.opt.wrap           = false -- Disable line wrapping

vim.opt.numberwidth    = 2     -- Width of the line number column
vim.opt.signcolumn     = "yes" -- Always show sign column
vim.opt.colorcolumn    = "100" -- Highlight column 100 to help identify long lines

vim.opt.autoindent     = true  -- Enable auto indentation
vim.opt.expandtab      = true  -- Use spaces instead of tabs
vim.opt.tabstop        = 4     -- Number of spaces for a tab
vim.opt.softtabstop    = 4     -- Number of spaces for a tab when editing
vim.opt.shiftwidth     = 4     -- Number of spaces for autoindent
vim.opt.shiftround     = true  -- Round indent to multiple of shiftwidth
--vim.opt.smartindent      = true


vim.opt.backup           = false     -- Disable file backup when overwriting
vim.opt.swapfile         = false     -- Disable swap files
vim.opt.undodir          = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile         = true      -- Enable persistent undo

vim.opt.hlsearch         = true      -- Enable highlighting of search results
vim.opt.incsearch        = true      -- Highlight as we type
vim.opt.inccommand       = "nosplit" -- Shows the effects of a command incrementally in the buffer

vim.opt.shell            = "fish"    -- Use fish shell in vim terminal

vim.opt.spell            = true      -- Enable spell check
vim.opt.spelllang        = "en_us"
vim.opt.spellsuggest     = "best"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus       = 3

vim.cmd.filetype("plugin indent on") -- Enable filetype detection, plugins, and indentation
