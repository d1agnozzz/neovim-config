require('plugins.lazy_bootstrap')

plugins = {
    { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
    { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    { 'numToStr/Comment.nvim', config = function()
        require('Comment').setup()
    end },
    'nvim-tree/nvim-web-devicons',
    'nvim-tree/nvim-tree.lua',
    'lambdalisue/suda.vim',
    'tpope/vim-fugitive',
    'TimUntersberger/neogit',
    { "kdheepak/lazygit.nvim", dependencies = { "nvim-lua/plenary.nvim", }, },
    
    -- LSP
    { "williamboman/mason.nvim", build = ":MasonUpdate" },
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',

    -- Autocompletion
    { 'ms-jpq/coq_nvim', branch = 'coq' },
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    { 'ms-jpq/coq.thirdparty', branch = '3p' },

    -- Colorschemes
    'morhetz/gruvbox',
    { 'ellisonleao/gruvbox.nvim', config = function()
        require('gruvbox').setup()
    end },
    'rebelot/kanagawa.nvim',
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'catppuccin/nvim', name = 'catppuccin' },
    'folke/tokyonight.nvim',
    'EdenEast/nightfox.nvim',
    'sainnhe/sonokai',
    { 'navarasu/onedark.nvim', config = function()
        require('onedark').setup {
            style = 'warmer'
        }
    end },
}

require('lazy').setup(plugins)

require('plugins.nvim-tree_config')
require('plugins.lsp_config')
require('plugins.treesitter_config')
require('plugins.fugitive_config')
