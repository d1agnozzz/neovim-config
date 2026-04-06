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

vim.keymap.set('n', '<leader>s', ':w<cr>', { desc = 'Save file' })

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

vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { desc = 'Escape terminal mode' })

vim.keymap.set('n', '=', [[<cmd>vertical resize +5<cr>]], { desc = 'Extend window vertically' })
vim.keymap.set('n', '-', [[<cmd>vertical resize -5<cr>]], { desc = 'Shrink windows vertically' })
vim.keymap.set('n', '+', [[<cmd>horizontal resize +2<cr>]], { desc = 'Extend window horizontally' })
vim.keymap.set('n', '_', [[<cmd>horizontal resize -2<cr>]], { desc = 'Shrink windows horizontally' }) -- make the window smaller horizontally by pressing shift and -

-- Copy full or relative path to currently open buffer
vim.keymap.set('n', '<leader>nf', function()
    local path = vim.fn.expand('%:p')
    vim.fn.setreg('+', path)
    vim.notify('Yanked absolute path: ' .. path, 'info', { title = 'Path' })
end)
vim.keymap.set('n', '<leader>nr', function()
    local path = './' .. vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    vim.notify('Yanked relative path: ' .. path, 'info', { title = 'Path' })
end)
