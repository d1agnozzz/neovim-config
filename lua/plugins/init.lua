require('plugins.lazy_bootstrap')


local plugins = {
    'lambdalisue/suda.vim',
    'tpope/vim-fugitive',
    'TimUntersberger/neogit',
    'nvim-tree/nvim-web-devicons',
    { 'nvim-telescope/telescope.nvim', dependencies = 'nvim-lua/plenary.nvim' },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'kdheepak/lazygit.nvim', dependencies = { 'nvim-lua/plenary.nvim', }, },
    { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
    { 'nvim-lualine/lualine.nvim', opts = require('plugins.lualine_config'), },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        main = 'nvim-treesitter.configs', 
        opts = require('plugins.treesitter_config'),
        dependencies = {
            'mrjones2014/nvim-ts-rainbow',
        }
    },
    { 'nvim-tree/nvim-tree.lua', opts = {}, init = function()
        vim.g.loaded_netrw = 1
        vim.g.loaded_netrwPlugin = 1
    end
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle' },
        ft = { 'markdown' },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    -- LSP
    { 
        'williamboman/mason.nvim', 
        build = ':MasonUpdate', 
        opts = {},
    },
    { 
        'williamboman/mason-lspconfig.nvim',
        opts = require('plugins.mason-lspconfig_config'),
    },
    { 
        'neovim/nvim-lspconfig',
        config = require('plugins.lsp_config'),
    },

    -- Autocompletion
    { 'ms-jpq/coq_nvim', branch = 'coq' },
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    { 'ms-jpq/coq.thirdparty', branch = '3p' },

    -- Colorschemes
    'morhetz/gruvbox',
    'rebelot/kanagawa.nvim',
    'folke/tokyonight.nvim',
    'EdenEast/nightfox.nvim',
    'sainnhe/sonokai',
    { 'ellisonleao/gruvbox.nvim', opts = {} },
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'catppuccin/nvim', name = 'catppuccin' },
    { 'ViViDboarder/wombat.nvim', dependencies = { 'rktjmp/lush.nvim', }, },
    { 'navarasu/onedark.nvim', config = function()
    require('onedark').setup {
        style = 'warmer'
    }
    end 
    },

}

require('lazy').setup({ 
    spec = plugins,
})

