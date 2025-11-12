vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.wrap = false

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.signcolumn = "yes"

vim.opt.colorcolumn = "100"

vim.opt.shell = "fish";

vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spellsuggest = "best"

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- Add custom filetype for Tiltfile
vim.filetype.add({
  pattern = {
    ['.*/*Tiltfile'] = 'starlark',
  },
})
-- Add custom filetype for .envrc files
vim.filetype.add({
  extension = {
    envrc = "sh"
  }
})
