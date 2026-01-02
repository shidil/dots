return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      require 'nvim-treesitter'.install { 'rust', 'javascript', 'zig', 'typescript', 'go', 'lua', 'yaml' }
    end
  },
}
