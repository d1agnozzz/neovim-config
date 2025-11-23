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
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'folke/neodev.nvim', opts = {} },
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

            -- Set up lspconfig.
            local capabilities = require('cmp_nvim_lsp').default_capabilities()
            -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
            -------------------------------------------------------------
            -- local lspconfig = require('lspconfig')
            -- local lspconfig = vim.lsp.config()
            -- local util = require('lspconfig.util')

            local servers = { 'pyright', 'lua_ls', 'ts_ls', 'texlab' }

            for _, lsp in ipairs(servers) do
                vim.lsp.config[lsp] = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                }
            end
        end,
    },
}
