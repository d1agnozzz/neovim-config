vim.g.mapleader = ' '

require('keymap.telescope')
require('keymap.lazygit')
require('keymap.nvim-tree')
require('keymap.fugitive')

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
