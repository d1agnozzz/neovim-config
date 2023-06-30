local telescope = require('telescope.builtin')

vim.keymap.set('n', '<c-p>', telescope.find_files, {desc = 'Telescope: find files'})
vim.keymap.set('n', '<leader>fg', telescope.live_grep, {desc = 'Telescope: live grep'})
vim.keymap.set('n', '<leader>fw', function()
    telescope.grep_string({search = vim.fn.input('Grep > ') })
end, {desc = 'Telescope: find word'})
vim.keymap.set('n', '<leader>fb', telescope.buffers, {desc = 'Telescope: buffers'})
vim.keymap.set('n', '<leader>fh', telescope.help_tags, {desc = 'Telescope: help tags'})

vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", {desc = 'Telescope: undo tree'})


