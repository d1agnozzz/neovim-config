return {
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            -- vim.cmd([[highlight IndentBlanklineIndent1 guibg=#2A2A37 gui=nocombine]])
            vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1b1b23 gui=nocombine]])
            -- local highlight = {
            --     -- 'IndentBlanklineIndent2',
            --     'CursorColumn',
            --     'Whitespace',
            -- }
            -- require('ibl').setup()
            -- require('ibl').setup({
            --     indent = { highlight = highlight, char = '' },
            --     whitespace = {
            --         highlight = highlight,
            --         remove_blankline_trail = false,
            --     },
            --     scope = { enabled = false },
            -- })
            vim.g.indent_blankline_filetype_exclude = {
                'lspinfo',
                'packer',
                'checkhealth',
                'help',
                'man',
                '',
                'dashboard',
            }
        end,
    },
}
