local M = {}

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

function M.setup_workdir_handling()
    augroup('DirectoryHandling', { clear = true })
    autocmd('VimEnter', {
        group = 'DirectoryHandling',
        callback = function()
            local args = vim.fn.argv()
            if #args == 1 and vim.fn.isdirectory(args[1]) == 1 then
                vim.cmd('cd ' .. args[1])
            end
        end,
    })
end
function M.format_on_save()
    augroup('FormatOnSave', {
        clear = true,
    })
    autocmd('BufWritePost', {
        group = 'FormatOnSave',
        callback = function()
            local ft = vim.bo.filetype
            -- Skip Go files
            if ft == 'go' then
                return
            end

            vim.cmd('FormatWrite')
        end,
    })
    autocmd('BufWritePre', {
        group = 'FormatOnSave',
        pattern = '*.go',
        callback = function()
            vim.lsp.buf.format()
        end,
    })
end

function M.neotest_output_goto_file_fix()
    autocmd('filetype', {
        pattern = 'neotest-output',
        callback = function()
            -- Open file under cursor in the widest window available.
            vim.keymap.set('n', 'gF', function()
                local current_word = vim.fn.expand('<cWORD>')
                local tokens = vim.split(current_word, ':', { trimempty = true })
                local win_ids = vim.api.nvim_list_wins()
                local widest_win_id = -1
                local widest_win_width = -1
                for _, win_id in ipairs(win_ids) do
                    if vim.api.nvim_win_get_config(win_id).zindex then
                        -- Skip floating windows.
                        goto continue
                    end
                    local win_width = vim.api.nvim_win_get_width(win_id)
                    if win_width > widest_win_width then
                        widest_win_width = win_width
                        widest_win_id = win_id
                    end
                    ::continue::
                end
                vim.api.nvim_set_current_win(widest_win_id)
                if #tokens == 1 then
                    vim.cmd('e ' .. tokens[1])
                else
                    vim.cmd('e +' .. tokens[2] .. ' ' .. tokens[1])
                end
            end, { remap = true, buffer = true })
        end,
    })
end

return M
