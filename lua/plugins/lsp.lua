return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- { 'folke/neodev.nvim', opts = {} },
            {
                {
                    'folke/lazydev.nvim',
                    ft = 'lua', -- only load on lua files
                    opts = {
                        library = {
                            -- See the configuration section for more details
                            -- Load luvit types when the `vim.uv` word is found
                            { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
                        },
                    },
                },
                { -- optional cmp completion source for require statements and module annotations
                    'hrsh7th/nvim-cmp',
                    opts = function(_, opts)
                        opts.sources = opts.sources or {}
                        table.insert(opts.sources, {
                            name = 'lazydev',
                            group_index = 0, -- set group index to 0 to skip loading LuaLS completions
                        })
                    end,
                },
                -- { "folke/neodev.nvim", enabled = false }, -- make sure to uninstall or disable neodev.nvim
            },
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
                vim.keymap.set(
                    'n',
                    'K',
                    function() vim.lsp.buf.hover({ border = 'rounded' }) end,
                    { remap = true, desc = 'LSP Hover' }
                )
            end

            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            local servers = { 'pylsp', 'lua_ls', 'rust_analyzer', 'gopls', 'buf_ls' }
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
                gopls = {
                    settings = {
                        ['gopls'] = {
                            buildFlags = {
                                '-tags=integration,integration_pg,integration_cassandra,integration_keydb,unit,db',
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
