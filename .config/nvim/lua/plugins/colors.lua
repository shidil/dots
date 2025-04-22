return {
    {
        "catppuccin/nvim",
        name = "catppuccin",
        config = function(_, _)
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
            })
            vim.cmd('colorscheme catppuccin-mocha')
        end
    },
}
