return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                build = ':MasonUpdate',
                opts = {},
            },
            {
                'williamboman/mason-lspconfig.nvim',
                opts = { ensure_installed = { 'lua_ls' } },
            },
            -- {
            --     'ms-jpq/coq_nvim',
            --     branch = 'coq',
            --     config = function() vim.cmd(':COQnow --shut-up') end,
            --     build = ':COQdeps',
            -- },
            -- { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
            -- { 'ms-jpq/coq.thirdparty', branch = '3p' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'hrsh7th/cmp-cmdline' },
            { 'hrsh7th/nvim-cmp' },
            {
                'L3MON4D3/LuaSnip',
                version = '2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
                dependencies = { 'rafamadriz/friendly-snippets' },
            },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'folke/neodev.nvim', opts = {} },
            {
                'simrat39/rust-tools.nvim',
                dependencies = 'nvim-lua/plenary.nvim',
                ft = 'rust',
            },
            { 'mfussenegger/nvim-dap' },
        },

        config = function()
            -- replace E, W, H letters in signcolumn with NerdFont icons
            local signs = { Error = ' ', Warn = '', Hint = '󰌵 ', Info = ' ' }
            for type, icon in pairs(signs) do
                local hl = 'DiagnosticSign' .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- keymappings for LSP
            local on_attach = function(client, _)
                local lsp_status = require('lsp-status')
                lsp_status.register_progress()
                lsp_status.on_attach(client)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'Rename symbol' })
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
                vim.keymap.set(
                    'n',
                    '<leader>e',
                    vim.diagnostic.open_float,
                    { desc = 'Show diagnostic in float window' }
                )

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP go definition' })
                vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'LSP go implementation' })
                vim.keymap.set(
                    'n',
                    'gr',
                    require('telescope.builtin').lsp_references,
                    { desc = 'LSP Telescope references' }
                )
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'LSP Hover' })
            end

            require('neodev').setup({})

            local cmp = require('cmp')
            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
            end

            local luasnip = require('luasnip')
            require('luasnip.loaders.from_vscode').lazy_load()
            cmp.setup({
                snippet = {
                    -- REQUIRED - you must specify a snippet engine
                    expand = function(args)
                        -- vim.fn['vsnip#anonymous'](args.body) -- For `vsnip` users.
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
                    end,
                },
                window = {
                    -- completion = cmp.config.window.bordered(),
                    -- documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
                        -- they way you will only jump inside the snippet region
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    -- { name = 'vsnip' }, -- For vsnip users.
                    { name = 'luasnip' }, -- For luasnip users.
                    -- { name = 'ultisnips' }, -- For ultisnips users.
                    -- { name = 'snippy' }, -- For snippy users.
                }, {
                    { name = 'buffer' },
                    { name = 'path' },
                    {
                        name = 'spell',
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                return require('cmp.config.context').in_treesitter_capture('spell')
                            end,
                        },
                    },
                }),
            })

            -- Set configuration for specific filetype.
            -- cmp.setup.filetype('gitcommit', {
            --     sources = cmp.config.sources({
            --         { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            --     }, {
            --         { name = 'buffer' },
            --     }),
            -- })

            -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' },
                },
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' },
                }, {
                    { name = 'cmdline' },
                }),
            })

            -- Set up lspconfig.
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            -------------------------------------------------------------
            local lspconfig = require('lspconfig')
            local util = require('lspconfig.util')

            local rt = require('rust-tools')
            rt.setup({
                server = {
                    on_attach = on_attach,
                    settings = {
                        ['rust-analyzer'] = {
                            cargo = {
                                allFeatures = true,
                            },
                            checkOnSave = {
                                allFeatures = true,
                                overrideCommand = {
                                    'cargo',
                                    'clippy',
                                    '--workspace',
                                    '--message-format=json',
                                    '--all-targets',
                                    '--all-features',
                                    '--',
                                    '-W',
                                    'clippy::correctness',
                                    '-W',
                                    'clippy::suspicious',
                                    '-W',
                                    'clippy::complexity',
                                    '-W',
                                    'clippy::perf',
                                    '-W',
                                    'clippy::style',
                                    '-W',
                                    'clippy::pedantic',
                                    -- '-W',
                                    -- 'clippy::restriction',
                                    -- '-W',
                                    -- 'clippy::cargo',
                                },
                            },
                        },
                    },
                },

                tools = {
                    inlay_hints = {
                        parameter_hints_prefix = ':',
                        other_hints_prefix = ':',
                    },
                },
            })

            local servers = { 'pyright', 'lua_ls', 'tsserver' }

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end

            --
            -- lspconfig.rust_analyzer.setup({
            --     on_attach = on_attach,
            --     root_dir = util.root_pattern('Cargo.toml'),
            --     settings = {
            --         ['rust-analyzer'] = {
            --             cargo = {
            --                 allFeatures = true,
            --             }
            --         }
            --     },
            --
            -- })
        end,
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        dependencies = 'nvim-lua/plenary.nvim',
        config = function()
            local null_ls = require('null-ls')

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.rustfmt,
                    null_ls.builtins.formatting.autopep8,
                    null_ls.builtins.formatting.black.with({
                        extra_args = { '--line-length=100' },
                    }),
                    null_ls.builtins.formatting.isort,

                    null_ls.builtins.completion.spell,
                },
            })
        end,
    },
}
