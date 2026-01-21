vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'go', 'rust', 'typescript', 'javascript' },
  callback = function() vim.treesitter.start() end,
})
