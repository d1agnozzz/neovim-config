return {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    branch = 'main',
    lazy = false,
    dependencies = {
        {
            'HiPhish/rainbow-delimiters.nvim',
        },
        'nvim-treesitter/nvim-treesitter-context',
        'JoosepAlviste/nvim-ts-context-commentstring',
        'windwp/nvim-ts-autotag',
        'RRethy/nvim-treesitter-endwise',
    },
    config = function()
        local ts = require('nvim-treesitter')

        -- State tracking for async parser loading
        -- local parsers_loaded = {}
        -- local parsers_pending = {}
        -- local parsers_failed = {}

        -- local ns = vim.api.nvim_create_namespace('treesitter.async')

        -- Helper to start highlighting and indentation
        local function start(buf, lang)
            local ok = pcall(vim.treesitter.start, buf, lang)
            if ok then
                vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                vim.wo[buf].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo[buf].foldmethod = 'expr'
                vim.wo[buf].foldlevel = 99
            end
            return ok
        end

        local langs = {
            'bash',
            'c',
            'css',
            'diff',
            'git_config',
            'git_rebase',
            'gitcommit',
            'gitignore',
            'go',
            'gomod',
            'gosum',
            'html',
            'json',
            'lua',
            'make',
            'markdown',
            'markdown_inline',
            'python',
            'query',
            'regex',
            'rust',
            'toml',
            'tsx',
            'vim',
            'vimdoc',
            'xml',
            'yaml',
        }

        -- -- Install core parsers after lazy.nvim finishes loading all plugins
        -- vim.api.nvim_create_autocmd('User', {
        --     pattern = 'LazyDone',
        --     once = true,
        --     callback = function()
        --         ts.install(langs, {
        --             max_jobs = 8,
        --         })
        --     end,
        -- })
        --
        -- -- Decoration provider for async parser loading
        -- vim.api.nvim_set_decoration_provider(ns, {
        --     on_start = vim.schedule_wrap(function()
        --         if #parsers_pending == 0 then return false end
        --         for _, data in ipairs(parsers_pending) do
        --             if vim.api.nvim_buf_is_valid(data.buf) then
        --                 if start(data.buf, data.lang) then
        --                     parsers_loaded[data.lang] = true
        --                 else
        --                     parsers_failed[data.lang] = true
        --                 end
        --             end
        --         end
        --         parsers_pending = {}
        --     end),
        -- })
        --
        -- local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

        -- local ignore_filetypes = {
        --     'checkhealth',
        --     'lazy',
        --     'mason',
        --     'snacks_dashboard',
        --     'snacks_notif',
        --     'snacks_win',
        -- }
        -- -- Auto-install parsers and enable highlighting on FileType
        -- vim.api.nvim_create_autocmd('FileType', {
        --     group = group,
        --     desc = 'Enable treesitter highlighting and indentation (non-blocking)',
        --     callback = function(event)
        --         if vim.tbl_contains(ignore_filetypes, event.match) then return end
        --
        --         local lang = vim.treesitter.language.get_lang(event.match) or event.match
        --         local buf = event.buf
        --
        --         if parsers_failed[lang] then return end
        --
        --         if parsers_loaded[lang] then
        --             -- Parser already loaded, start immediately (fast path)
        --             start(buf, lang)
        --         else
        --             -- Queue for async loading
        --             table.insert(parsers_pending, { buf = buf, lang = lang })
        --         end
        --
        --         -- Auto-install missing parsers (async, no-op if already installed)
        --         ts.install({ lang })
        --     end,
        -- })

        local dir = vim.fn.stdpath('data') .. '/site'
        require('nvim-treesitter.config').setup({
            install_dir = dir,
        })
        -- vim.opt.runtimepath:prepend(dir)
        require('nvim-treesitter').install(langs)
        vim.api.nvim_create_autocmd('FileType', {
            pattern = langs,
            callback = function()
                -- syntax highlighting, provided by Neovim
                vim.treesitter.start()
                -- folds, provided by Neovim
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo.foldmethod = 'expr'
                -- indentation, provided by nvim-treesitter
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        -- ensure_installed = {
        --     'c',
        --     'css',
        --     'html',
        --     'json',
        --     'lua',
        --     'markdown',
        --     'markdown_inline',
        --     'python',
        --     'query',
        --     'regex',
        --     'rust',
        --     'tsx',
        --     'vim',
        --     'vimdoc',
        --     'yaml',
        -- },
        --
        -- sync_install = false,
        --
        -- auto_install = true,
        --
        -- highlight = {
        --     enable = true,
        --     disable = function(lang, buf)
        --         local max_filesize = 80 * 1024 -- 80 KB
        --         local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        --         if ok and stats and stats.size > max_filesize then return true end
        --     end,
        --     additional_vim_regex_highlighting = false,
        -- },
        -- indent = { enable = true },
        -- autotag = {
        --     enable = true,
        -- },
        -- endwise = {
        --     enable = true,
        -- },
    end,
}
