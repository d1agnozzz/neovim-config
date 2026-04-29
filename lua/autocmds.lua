local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

function M.setup_workdir_handling()
    augroup('DirectoryHandling', { clear = true })
    autocmd('VimEnter', {
        group = 'DirectoryHandling',
        callback = function()
            local args = vim.fn.argv()
            if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then vim.cmd('cd ' .. args[1]) end
        end,
    })
end

function M.format_on_save()
    augroup('FormatOnSave', {
        clear = true,
    })
    autocmd('BufWritePost', {
        group = 'FormatOnSave',
        command = 'FormatWrite',
    })
end

return M
