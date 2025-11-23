vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'UFO: Open all folds' })
vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'UFO: Close all folds' })
vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
vim.keymap.set('n', 'zK', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
        -- choose one of coc.nvim and nvim lsp
        vim.fn.CocActionAsync('definitionHover') -- coc.nvim
        vim.lsp.buf.hover()
    end
end, { desc = 'UFO: Peek fold' })
