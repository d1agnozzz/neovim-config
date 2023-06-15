vim.g.mapleader = ' '

require('keymap.telescope')
require('keymap.lazygit')
require('keymap.nvim-tree')
require('keymap.fugitive')

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Swap lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep selection after indenting 
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '<', '<gv')
