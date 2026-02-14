return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            { 'folke/neodev.nvim', opts = {} },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'mfussenegger/nvim-dap' },
        },

        config = function()
            -- replace E, W, H letters in signcolumn with NerdFont icons
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = ' ',
                        [vim.diagnostic.severity.WARN] = ' ',
                        [vim.diagnostic.severity.INFO] = ' ',
                        [vim.diagnostic.severity.HINT] = '󰌵 ',
                    },
                    linehl = {
                        [vim.diagnostic.severity.ERROR] = 'Error',
                        [vim.diagnostic.severity.WARN] = 'Warn',
                        [vim.diagnostic.severity.INFO] = 'Info',
                        [vim.diagnostic.severity.HINT] = 'Hint',
                    },
                },
            })

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

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local servers = { 'pyright', 'lua_ls', 'rust_analyzer', 'gopls' }
            -- vim.lsp.enable({"lua_ls"})
            vim.lsp.inlay_hint.enable(true)

            local lsp_configs = {
                rust_analyzer = {
                    settings = {
                        ['rust-analyzer'] = {
                            check = {
                                command = 'clippy',
                            },
                        },
                    },
                },
            }

            for _, lsp in ipairs(servers) do
                local config = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    settings = {},
                }
                if lsp_configs[lsp] then config.settings = lsp_configs[lsp].settings end
                vim.lsp.config[lsp] = config
                vim.lsp.enable(lsp)
            end
        end,
    },
}
