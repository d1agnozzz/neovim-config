return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    config = function()
        require('nvim-treesitter.configs').setup({
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
                'tsx',
                'json',
                'yaml',
                'html',
                'css',
            },

            sync_install = false,

            auto_install = true,

            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 80 * 1024 -- 80 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then return true end
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = { enable = true },
            autotag = {
                enable = true,
            },
            endwise = {
                enable = true,
            },
        })
    end,
    dependencies = {
        {
            'HiPhish/rainbow-delimiters.nvim',
        },
        'nvim-treesitter/nvim-treesitter-context',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag',
        'RRethy/nvim-treesitter-endwise',
    },
}
