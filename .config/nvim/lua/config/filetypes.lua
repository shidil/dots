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

-- Enable tree sitter for these file types
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'rust', 'typescript', 'javascript' },
  callback = function() vim.treesitter.start() end,
})
