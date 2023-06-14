local telescope = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', telescope.find_files, {})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {})
vim.keymap.set('n', '<leader>fw', function()
    telescope.grep_string({search = vim.fn.input('Grep > ') })
end)
vim.keymap.set('n', '<leader>fb', telescope.buffers, {})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {})


