vim.keymap.set('n', '<leader>tt', '<cmd>Trouble diagnostics toggle focus=false filter.buf=0<cr>', { desc = 'Trouble' })
vim.keymap.set(
    'n',
    '<leader>tw',
    '<cmd>TroubleToggle diagnostics toggle focus=false<cr>',
    { desc = 'Trouble (workspace mode)' }
)
vim.keymap.set('n', '<leader>tq', '<cmd>Trouble quickfix toggle <cr>', { desc = 'Trouble (quickfix)' })
vim.keymap.set('n', '<leader>tl', '<cmd>Trouble loclist toggle<cr>', { desc = 'Trouble (loclist)' })

vim.keymap.set('n', 'gR', '<cmd>Trouble lsp_references toggle<cr>', { desc = 'Trouble (LSP references)' })
vim.keymap.set('n', 'gD', '<cmd>Trouble lsp_definitions toggle<cr>', { desc = 'Trouble (LSP definitions)' })
vim.keymap.set('n', 'gI', '<cmd>Trouble lsp_implementations toggle<cr>', { desc = 'Trouble (LSP implementations)' })

vim.keymap.set(
    'n',
    '<leader>cs',
    '<cmd>Trouble lsp_document_symbols toggle focus=true win = { type = split, position = right}<cr>'
)
vim.keymap.set('n', '<leader>cS', '<cmd>Trouble symbols toggle focus=false win = {type = split, position = right}<cr>')
