Current_colorscheme = 'kanagawa'

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
require('lazy').setup('plugins')
require('keymap')
require('set')
vim.g.sonokai_enable_italic = 1
vim.cmd.colorscheme(Current_colorscheme)
