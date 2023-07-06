local lsp = require('lsp-zero').preset({
    manage_nvim_cmp = {
        set_sources = 'recommended'
    }
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
    vim.keymap.set('n', 'ga', vim.lsp.buf.code_action)
    vim.keymap.set('n', 'gA', function()
        vim.lsp.buf.code_action({
            context = {
                only = {
                    "source",
                },
                diagnostics = {},
            },
        })
    end)
end)


lsp.ensure_installed({
    -- Replace these with whatever servers you want to install
    'tsserver',
    'eslint',
    'rust_analyzer',
    'gopls',
    'lua_ls',
})

lsp.format_on_save({
    servers = {
        ['lua_ls'] = { 'lua' },
        ['rust_analyzer'] = { 'rust' },
        ['gopls'] = { 'go' },
        ['null-ls'] = { 'typescript', 'javascript', 'lua', 'typescriptreact' },
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<C-Space>'] = cmp.mapping.confirm({ select = true }),
})

lsp.setup_nvim_cmp({ mapping = cmp_mappings })

-- (Optional) Configure lua language server for neovim
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())

lsp.setup()

local null_ls = require("null-ls")
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
        ---
        -- you can add other stuff here....
        ---
    end,
    sources = {
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.completion.spell,
    },
})
