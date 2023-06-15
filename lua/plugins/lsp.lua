-- LSP
return    {
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
                opts = { },
                ensure_installed = { 'lua_ls' }
            },
        },

        config = function()
            local on_attach = function(_, _)
                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
                vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
                vim.keymap.set('n', 'gd', vim.lsp.buf.implementation, {})
                vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            end

            local lspconfig = require('lspconfig')
            lspconfig.lua_ls.setup {
                on_attach = on_attach
            }
            lspconfig.rust_analyzer.setup {
                on_attach = on_attach
            }

        end
    }
}

