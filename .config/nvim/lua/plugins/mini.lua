return {
  { "echasnovski/mini.pairs",     config = true },
  { "echasnovski/mini.comment",   config = true },
  { "echasnovski/mini.splitjoin", config = true },
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
        line_left = '<S-h>',
        line_right = '<S-l>',
        line_down = '<S-j>',
        line_up = '<S-k>',
      },
    }
  },
  -- { "echasnovski/mini.surround", },
  -- TODO: ssddsd FIXME NOTE HACK
  { "echasnovski/mini.bracketed", config = true },
  {
    "echasnovski/mini.hipatterns",
    config = function()
      local hipatterns = require('mini.hipatterns')
      hipatterns.setup({
        highlighters = {
          -- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
          fixme     = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
          hack      = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
          todo      = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
          note      = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
          review    = { pattern = '%f[%w]()REVIEW()%f[%W]', group = 'MiniHipatternsReview' },

          -- Highlight hex color strings (`#rrggbb`) using that color
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })
    end
  },
}
