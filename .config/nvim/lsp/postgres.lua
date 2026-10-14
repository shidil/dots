--- @brief
--- https://github.com/gmr/postgres-lsp
---
--- postgres-lsp A Language Server Protocol (LSP) implementation for PostgreSQL and PL/pgSQL, built with tree-sitter-postgres and tower-lsp.

---@type vim.lsp.Config
return {
  cmd = { 'postgres-lsp' },
  filetypes = { 'sql' },
  root_markers = { '.git' },
  reuse_client = function(client, config)
    -- Reuse the client if the name matches the config name
    return client.name == config.name
  end,
}
