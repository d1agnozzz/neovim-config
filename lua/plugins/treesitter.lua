return  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = {
            'c',
            'lua',
            'vim',
            'vimdoc',
            'query',
            'rust',
            'python',
            'markdown',
            'markdown_inline',
        },

        sync_install = false,

        auto_install = true,

        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
    },
    dependencies = {
        {
            'HiPhish/nvim-ts-rainbow2',
            config = function()
                require('nvim-treesitter.configs').setup {

                    rainbow = {
                        enable = true,
                        -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
                        query = 'rainbow-parens',
                        strategy = require('ts-rainbow').strategy[ 'global' ],
                    }
                }
            end
        },
        'nvim-treesitter/nvim-treesitter-context',
        'JoosepAlviste/nvim-ts-context-commentstring',
    }
}
