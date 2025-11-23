vim.keymap.set('n', '<c-n>', function()
    if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
end)
