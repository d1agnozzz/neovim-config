vim.g.mapleader = ' '

require('keymap.plugins.telescope')
require('keymap.plugins.lazygit')
require('keymap.plugins.nvim-tree')
require('keymap.plugins.fugitive')
require('keymap.plugins.coq')
-- require('keymap.plugins.autopairs')
require('keymap.plugins.trouble')
require('keymap.plugins.formatter')
require('keymap.plugins.dap')
require('keymap.plugins.ufo')

-- Yank to system clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]])
vim.keymap.set('n', '<leader>Y', [["+Y]])

-- Swap lines
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keep selection after indenting
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')

-- Write changes, close buffer and open second last opened buffer
-- vim.keymap.set('n', '<leader>wq', ':w<bar>bd<bar>b#<bar>b#<cr>')
vim.keymap.set('n', '<leader>d', function()
    -- Check if the current buffer is the last one
    if #vim.fn.getbufinfo({ buflisted = true }) == 1 then
        -- Open nvim-tree
        vim.cmd('w|bd|NvimTreeToggle')
    -- Alternatively, you can close neovim using the following command
    -- vim.cmd('qa')
    else
        -- Save and close the current buffer
        vim.cmd('w|bd|b#|b#')
    end
end)
vim.keymap.set('n', '<c-s>', ':w<cr>')
vim.keymap.set('n', '<c-q>', ':qa!<cr>')

-- Switch buffers
vim.keymap.set('n', '<leader>bp', ':bprevious<cr>')
vim.keymap.set('n', '<leader>bn', ':bnext<cr>')

-- Disable search highlight
vim.keymap.set('n', '<leader>/', ':set hlsearch!<cr>', { noremap = true, silent = true })
