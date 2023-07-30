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
            {
                'ms-jpq/coq_nvim',
                branch = 'coq',
                config = function() vim.cmd(':COQnow --shut-up') end,
                build = ':COQdeps',
            },
            { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
            { 'ms-jpq/coq.thirdparty', branch = '3p' },
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
            local on_attach = function(_, _)
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

            local lspconfig = require('lspconfig')
            local util = require('lspconfig.util')

            local servers = { 'pyright', 'lua_ls' }

            for _, lsp in ipairs(servers) do
                lspconfig[lsp].setup(require('coq').lsp_ensure_capabilities({
                    on_attach = on_attach,
                }))
            end

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
                                    '-W',
                                    'clippy::cargo',
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
