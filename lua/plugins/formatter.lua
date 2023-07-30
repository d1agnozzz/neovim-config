return {
    {
        'mhartington/formatter.nvim',
        config = function()
            -- Utilities for creating configurations
            local util = require('formatter.util')

            -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
            require('formatter').setup({
                -- Enable or disable logging
                logging = true,
                -- Set the log level
                log_level = vim.log.levels.WARN,
                -- All formatter configurations are opt-in
                filetype = {
                    -- Formatter configurations for filetype "lua" go here
                    -- and will be executed in order
                    lua = {
                        function()
                            -- Full specification of configurations is down below and in Vim help
                            -- files
                            return {
                                exe = 'stylua',
                                args = {
                                    '--search-parent-directories',
                                    '--stdin-filepath',
                                    util.escape_path(util.get_current_buffer_file_path()),
                                    '--',
                                    '-',
                                },
                                stdin = true,
                            }
                        end,
                    },
                    rust = {
                        function()
                            return {
                                exe = 'rustfmt',
                                stdin = true,
                            }
                        end,
                    },
                    py = {
                        function()
                            return {
                                exe = 'black',
                                args = { '-q', '-' },
                                stdin = true,
                            }
                        end,
                        function()
                            return {
                                exe = 'autopep8',
                                args = { '-' },
                                stdin = 1,
                            }
                        end,
                        function()
                            return {
                                exe = 'isort',
                                args = { '-q', '-' },
                                stdin = true,
                            }
                        end,
                    },

                    -- Use the special "*" filetype for defining formatter configurations on
                    -- any filetype
                    ['*'] = {
                        -- "formatter.filetypes.any" defines default configurations for any
                        -- filetype
                        require('formatter.filetypes.any').remove_trailing_whitespace,
                    },
                },
            })

            vim.api.nvim_create_augroup('FormatOnSave', {
                clear = true
            })
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = 'FormatOnSave',
                command = 'FormatWrite'
            })
        end,
    },
}
