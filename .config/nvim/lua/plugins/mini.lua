return {
  { "echasnovski/mini.pairs",     config = true },
  { "echasnovski/mini.comment",   config = true },
  { "echasnovski/mini.splitjoin", config = true },
  { "echasnovski/mini.diff",      config = true },
  {
    "echasnovski/mini.move",
    config = true,
    opts = {
      mappings = {
        -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
        left = '<S-h>',
        right = '<S-l>',
        down = '<S-j>',
        up = '<S-k>',
        -- Move current line in Normal mode
        line_left = '',
        line_right = '',
        line_down = '',
        line_up = '',
      },
    }
  },
  -- { "echasnovski/mini.surround", },
  { "echasnovski/mini.bracketed", config = true },
  {
    "echasnovski/mini.hipatterns",
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'TODO', 'REVIEW'
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsHack' },
          note      = { pattern = '%f[%w]()REVIEW()%f[%W]', group = 'MiniHipatternsNote' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
