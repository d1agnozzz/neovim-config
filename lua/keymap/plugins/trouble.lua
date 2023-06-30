vim.keymap.set('n', '<leader>tt', '<cmd>TroubleToggle<cr>', {desc = 'Trouble'})
vim.keymap.set('n', '<leader>tw', '<cmd>TroubleToggle workspace_diagnostics<cr>', {desc = 'Trouble (workspace mode)'})
vim.keymap.set('n', '<leader>td', '<cmd>TroubleToggle document_diagnostics<cr>', {desc = 'Trouble (document mode)'})
vim.keymap.set('n', '<leader>tq', '<cmd>TroubleToggle quickfix<cr>', {desc = 'Trouble (quickfix)'})
vim.keymap.set('n', '<leader>tl', '<cmd>TroubleToggle loclist<cr>', {desc = 'Trouble (loclist)'})

vim.keymap.set('n', 'gR', '<cmd>TroubleToggle lsp_references<cr>', {desc = 'Trouble (LSP references)'})
vim.keymap.set('n', 'gD', '<cmd>TroubleToggle lsp_definitions<cr>', {desc = 'Trouble (LSP definitions)'})
vim.keymap.set('n', 'gI', '<cmd>TroubleToggle lsp_implementations<cr>', {desc = 'Trouble (LSP implementations)'})
