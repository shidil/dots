local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    --"folke/which-key.nvim",
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- { "jvgrootveld/telescope-zoxide" },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function(_, _)
            vim.cmd(
                'colorscheme catppuccin-mocha')
        end
    },
    { "nvim-tree/nvim-web-devicons" },
    { "nvim-treesitter/nvim-treesitter",            name = "treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/nvim-treesitter-textobjects" },
    -- { "nvim-treesitter/playground" },
    { "ThePrimeagen/harpoon",                       event = "VeryLazy" },
    { "mbbill/undotree" },
    -- { "tpope/vim-fugitive" },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {
                -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.cmd, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            {
                "L3MON4D3/LuaSnip",
                dependencies = { "rafamadriz/friendly-snippets" },
            },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-buffer' },
            {
                'lewis6991/gitsigns.nvim',
                opts = function()
                    require('gitsigns').setup()
                end
            },
        }
    },
    { "jose-elias-alvarez/null-ls.nvim",     event = "VeryLazy" },
    { "lukas-reineke/indent-blankline.nvim", event = "VeryLazy" },
    { "nvim-lualine/lualine.nvim",           event = "VeryLazy" },
    -- auto pairs
    {
        "echasnovski/mini.pairs",
        event = "VeryLazy",
        config = function(_, opts)
            require("mini.pairs").setup(opts)
        end,
    },
    --{'akinsho/bufferline.nvim', version = "v3.*", dependencies = 'nvim-tree/nvim-web-devicons'}
    -- surround
    {
        "echasnovski/mini.surround",
        event = "VeryLazy",
        keys = function(_, keys)
            -- Populate the keys based on the user's options
            local plugin = require("lazy.core.config").spec.plugins["mini.surround"]
            local opts = require("lazy.core.plugin").values(plugin, "opts", false)
            local mappings = {
                { opts.mappings.add,            desc = "Add surrounding",                     mode = { "n", "v" } },
                { opts.mappings.delete,         desc = "Delete surrounding" },
                { opts.mappings.find,           desc = "Find right surrounding" },
                { opts.mappings.find_left,      desc = "Find left surrounding" },
                { opts.mappings.highlight,      desc = "Highlight surrounding" },
                { opts.mappings.replace,        desc = "Replace surrounding" },
                { opts.mappings.update_n_lines, desc = "Update `MiniSurround.config.n_lines`" },
            }
            mappings = vim.tbl_filter(function(m)
                return m[1] and #m[1] > 0
            end, mappings)
            return vim.list_extend(mappings, keys)
        end,
        opts = {
            mappings = {
                add = "gza",            -- Add surrounding in Normal and Visual modes
                delete = "gzd",         -- Delete surrounding
                find = "gzf",           -- Find surrounding (to the right)
                find_left = "gzF",      -- Find surrounding (to the left)
                highlight = "gzh",      -- Highlight surrounding
                replace = "gzr",        -- Replace surrounding
                update_n_lines = "gzn", -- Update `n_lines`
            },
        },
        config = function(_, opts)
            -- use gz mappings instead of s to prevent conflict with leap
            require("mini.surround").setup(opts)
        end,
    },
    {
        "ggandor/leap.nvim",
        event = "VeryLazy",
        config = function(_, opts)
            require('leap').add_default_mappings()
        end
    },
    { "mg979/vim-visual-multi", event = "VeryLazy" }
})
