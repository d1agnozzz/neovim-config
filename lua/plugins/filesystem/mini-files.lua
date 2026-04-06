return {
    {
        'nvim-mini/mini.files',
        version = false,
        config = function()
            require('mini.files').setup({
                windows = { preview = true },
            })

            -- Set focused directory as current working directory
            local set_cwd = function()
                local path = (MiniFiles.get_fs_entry() or {}).path
                if path == nil then return vim.notify('Cursor is not on valid entry') end
                vim.fn.chdir(vim.fs.dirname(path))
            end

            -- Yank in register full path of entry under cursor
            --- @param abs boolean
            local yank_path = function(abs)
                local fs_entry
                if abs then fs_entry = (MiniFiles.get_fs_entry() or {}) end
                if not abs then
                    fs_entry = (MiniFiles.get_fs_entry() or {})
                    fs_entry.path = './' .. vim.fn.fnamemodify(fs_entry.path, ':.')
                end
                if fs_entry == nil then return vim.notify('Cursor is not on valid entry') end
                vim.fn.setreg('+', fs_entry.path)
                vim.notify(
                    'Yanked ' .. (abs and 'absolute' or 'relative') .. ' path: ' .. fs_entry.path,
                    'info',
                    { title = 'Path' }
                )
            end

            -- Open path with system default handler (useful for non-text files)
            local ui_open = function() vim.ui.open(MiniFiles.get_fs_entry().path) end

            vim.api.nvim_create_autocmd('User', {
                pattern = 'MiniFilesBufferCreate',
                callback = function(args)
                    local b = args.data.buf_id
                    vim.keymap.set('n', 'sh', set_cwd, { buffer = b, desc = 'Set cwd' })
                    vim.keymap.set('n', 'gX', ui_open, { buffer = b, desc = 'OS open' })
                    vim.keymap.set('n', 'gy', function() yank_path(false) end, { buffer = b, desc = 'Yank path' })
                    vim.keymap.set('n', 'gY', function() yank_path(true) end, { buffer = b, desc = 'Yank path' })
                end,
            })
        end,
    },
}
