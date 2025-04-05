local builtin = require('telescope.builtin')
require('telescope').setup {
    pickers = {
        find_files = { theme = "ivy" },
        git_files = { theme = "ivy" },
        grep_string = { theme = "ivy" },
    }
}
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>pF', builtin.git_files, {})
vim.keymap.set('n', '<leader>pb', builtin.buffers, {})
vim.keymap.set('n', '<leader>po', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>pd', builtin.diagnostics, {})
-- vim.keymap.set('n', '<leader>pp', require("telescope").extensions.zoxide.list, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
