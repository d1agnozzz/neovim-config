return {
    {
        'mhartington/formatter.nvim',
        config = function()
            -- Utilities for creating configurations
            local util = require('formatter.util')
            local defaults = require('formatter.defaults')
            local filetypes = require('formatter.filetypes')

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
                    lua = filetypes.lua.stylua,
                    rust = {
                        function()
                            return {
                                exe = 'rustfmt',
                                stdin = true,
                            }
                        end,
                    },
                    go = {
                        function()
                            return {
                                exe = 'gofmt',
                                stdin = true,
                            }
                        end,
                    },
                    python = {
                        filetypes.python.black,
                        filetypes.python.autopep8,
                        filetypes.python.isort,
                    },
                    typescript = {
                        util.withl(defaults.prettier, 'typescript'),
                    },
                    typescriptreact = {
                        util.withl(defaults.prettier, 'typescript'),
                    },
                    tex = {
                        function()
                            return {
                                exe = 'latexindent',
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
                clear = true,
            })
            vim.api.nvim_create_autocmd('BufWritePost', {
                group = 'FormatOnSave',
                command = 'FormatWrite',
            })
        end,
    },
}
