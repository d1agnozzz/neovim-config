vim.g.mapleader = ' '

require('keymap.plugins.telescope')
require('keymap.plugins.lazygit')
require('keymap.plugins.mini-files')
require('keymap.plugins.fugitive')
require('keymap.plugins.trouble')
require('keymap.plugins.formatter')
require('keymap.plugins.dap')
require('keymap.plugins.ufo')

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Copy to clipboard' })
vim.keymap.set('n', '<leader>Y', [["+Y]], { desc = 'Copy to clipboard' })

-- Close buffer and open second last opened buffer
vim.keymap.set('n', '<leader>q', function()
    -- Check if the current buffer is the last one
    if #vim.fn.getbufinfo({ buflisted = true }) == 1 then
        -- Open file manager
        vim.cmd('bd|lua MiniFiles.open()')
        -- Alternatively, you can close neovim using the following command
        -- vim.cmd('qa')
    else
        -- close the current buffer
        vim.cmd('bd|b#|b#')
    end
end, { desc = 'Close Buffer' })

vim.keymap.set('n', '<leader>Q', function()
    -- Check if the current buffer is the last one
    if #vim.fn.getbufinfo({ buflisted = true }) == 1 then
        -- Open file manager
        vim.cmd('bd!|lua MiniFiles.open()')
        -- Alternatively, you can close neovim using the following command
        -- vim.cmd('qa')
    else
        -- close the current buffer
        vim.cmd('bd!|b#|b#')
    end
end, { desc = 'Close Buffer!' })

vim.keymap.set('n', '<c-s>', ':w<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<c-Q>', ':qa!<cr>')

-- Switch buffers
vim.keymap.set('n', '<leader>h', ':bprevious<cr>', { desc = 'Previous Buffer' })
vim.keymap.set('n', '<leader>l', ':bnext<cr>', { desc = 'Next Buffer' })

-- Disable search highlight
vim.keymap.set(
    'n',
    '<leader>/',
    ':set hlsearch!<cr>',
    { noremap = true, silent = true, desc = 'Disable search highlight' }
)
