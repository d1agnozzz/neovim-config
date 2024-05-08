local HEIGHT_RATIO = 0.8 -- You can change this
local WIDTH_RATIO = 0.5 -- You can change this too

return {
    -- { 'norcalli/nvim-colorizer.lua', opts = {} },
    { -- Color highlighting and color picker
        'uga-rosa/ccc.nvim',
        config = function()
            local ColorInput = require('ccc.input')
            local convert = require('ccc.utils.convert')

            local RgbHslCmykInput = setmetatable({
                name = 'RGB/HSL/CMYK',
                max = { 1, 1, 1, 360, 1, 1, 1, 1, 1, 1 },
                min = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                delta = { 1 / 255, 1 / 255, 1 / 255, 1, 0.01, 0.01, 0.005, 0.005, 0.005, 0.005 },
                bar_name = { 'R', 'G', 'B', 'H', 'S', 'L', 'C', 'M', 'Y', 'K' },
            }, { __index = ColorInput })

            function RgbHslCmykInput.format(n, i)
                if i <= 3 then
                    -- RGB
                    n = n * 255
                elseif i == 5 or i == 6 then
                    -- S or L of HSL
                    n = n * 100
                elseif i >= 7 then
                    -- CMYK
                    return ('%5.1f%%'):format(math.floor(n * 200) / 2)
                end
                return ('%6d'):format(n)
            end

            function RgbHslCmykInput.from_rgb(RGB)
                local HSL = convert.rgb2hsl(RGB)
                local CMYK = convert.rgb2cmyk(RGB)
                local R, G, B = unpack(RGB)
                local H, S, L = unpack(HSL)
                local C, M, Y, K = unpack(CMYK)
                return { R, G, B, H, S, L, C, M, Y, K }
            end

            function RgbHslCmykInput.to_rgb(value) return { value[1], value[2], value[3] } end

            function RgbHslCmykInput:_set_rgb(RGB)
                self.value[1] = RGB[1]
                self.value[2] = RGB[2]
                self.value[3] = RGB[3]
            end

            function RgbHslCmykInput:_set_hsl(HSL)
                self.value[4] = HSL[1]
                self.value[5] = HSL[2]
                self.value[6] = HSL[3]
            end

            function RgbHslCmykInput:_set_cmyk(CMYK)
                self.value[7] = CMYK[1]
                self.value[8] = CMYK[2]
                self.value[9] = CMYK[3]
                self.value[10] = CMYK[4]
            end

            function RgbHslCmykInput:callback(index, new_value)
                self.value[index] = new_value
                local v = self.value
                if index <= 3 then
                    local RGB = { v[1], v[2], v[3] }
                    local HSL = convert.rgb2hsl(RGB)
                    local CMYK = convert.rgb2cmyk(RGB)
                    self:_set_hsl(HSL)
                    self:_set_cmyk(CMYK)
                elseif index <= 6 then
                    local HSL = { v[4], v[5], v[6] }
                    local RGB = convert.hsl2rgb(HSL)
                    local CMYK = convert.rgb2cmyk(RGB)
                    self:_set_rgb(RGB)
                    self:_set_cmyk(CMYK)
                else
                    local CMYK = { v[7], v[8], v[9], v[10] }
                    local RGB = convert.cmyk2rgb(CMYK)
                    local HSL = convert.rgb2hsl(RGB)
                    self:_set_rgb(RGB)
                    self:_set_hsl(HSL)
                end
            end

            local ccc = require('ccc')
            ccc.setup({
                inputs = {
                    RgbHslCmykInput,
                },
                highlighter = {
                    auto_enable = true,
                    lsp = true,
                },
            })
        end,
    },
    { 'RRethy/vim-illuminate' },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        config = function()
            vim.opt.foldcolumn = '0'
            vim.opt.foldlevel = 999
            vim.opt.foldlevelstart = 999
            vim.opt.foldenable = true

            require('ufo').setup({
                provider_selector = function(bufnr, filetype, buftype) return { 'treesitter', 'indent' } end,
            })
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = function()
            -- vim.cmd([[highlight IndentBlanklineIndent1 guibg=#2A2A37 gui=nocombine]])
            vim.cmd([[highlight IndentBlanklineIndent2 guibg=#1b1b23 gui=nocombine]])
            local highlight = {
                'IndentBlanklineIndent2',
                'Whitespace',
            }
            require('ibl').setup({
                indent = { highlight = highlight, char = '' },
                whitespace = {
                    highlight = highlight,
                    remove_blankline_trail = false,
                },
                scope = { enabled = false },

                -- char = '',
                -- char_highlight_list = {
                --     'IndentBlanklineIndent1',
                --     'IndentBlanklineIndent2',
                -- },
                -- space_char_highlight_list = {
                --     'IndentBlanklineIndent1',
                --     'IndentBlanklineIndent2',
                -- },
                -- show_trailing_blankline_indent = false,
            })
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
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle' },
        ft = { 'markdown' },
        build = function() vim.fn['mkdp#util#install']() end,
    },
    {
        'folke/trouble.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            signs = {
                -- icons / text used for a diagnostic
                error = '',
                warning = '',
                hint = '',
                information = '',
                other = '',
            },
            use_diagnostic_signs = true, -- enabling this will use the signs defined in your lsp client
        },
    },
    {
        'folke/todo-comments.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        'nvim-tree/nvim-web-devicons',
        opts = {
            -- your personnal icons can go here (to override)
            -- you can specify color or cterm_color instead of specifying both of them
            -- DevIcon will be appended to `name`
            override = {
                zsh = {
                    icon = '',
                    color = '#428850',
                    cterm_color = '65',
                    name = 'Zsh',
                },
            },
            -- globally enable different highlight colors per icon (default to true)
            -- if set to false all icons will have the default icon's color
            color_icons = true,
            -- globally enable default icons (default to false)
            -- will get overriden by `get_icons` option
            default = true,
            -- globally enable "strict" selection of icons - icon will be looked up in
            -- different tables, first by filename, and if not found by extension; this
            -- prevents cases when file doesn't have any extension but still gets some icon
            -- because its name happened to match some extension (default to false)
            strict = true,
            -- same as `override` but specifically for overrides by filename
            -- takes effect when `strict` is true
            override_by_filename = {
                ['.gitignore'] = {
                    icon = '',
                    color = '#f1502f',
                    name = 'Gitignore',
                },
            },
            -- same as `override` but specifically for overrides by extension
            -- takes effect when `strict` is true
            override_by_extension = {
                ['log'] = {
                    icon = '',
                    color = '#81e043',
                    name = 'Log',
                },
            },
        },
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'debugloop/telescope-undo.nvim',
        },
        config = function()
            local telescope = require('telescope')
            telescope.setup({
                pickers = {
                    colorscheme = {
                        enable_preview = true,
                    },
                },
                extensions = {
                    undo = {
                        side_by_side = true,
                        -- layout_strategy = "vertical",
                        layout_config = {
                            preview_width = 0.8,
                        },
                        mappings = {
                            i = {
                                -- IMPORTANT: Note that telescope-undo must be available when telescope is configured if
                                -- you want to replicate these defaults and use the following actions. This means
                                -- installing as a dependency of telescope in it's `requirements` and loading this
                                -- extension from there instead of having the separate plugin definition as outlined
                                -- above.
                                ['<C-cr>'] = require('telescope-undo.actions').yank_additions,
                                ['<S-cr>'] = require('telescope-undo.actions').yank_deletions,
                                ['<cr>'] = require('telescope-undo.actions').restore,
                            },
                        },
                    },
                },
            })
            telescope.load_extension('undo')
        end,
    },
    { 'nvim-lua/lsp-status.nvim' },
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            local lsp_status = require('lsp-status')
            lsp_status.register_progress()
            require('lualine').setup({
                options = {
                    icons_enabled = true,
                    theme = 'auto',
                    component_separators = { left = '|', right = '|' },
                    section_separators = { left = '', right = '' },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = { 'NvimTree' },
                    always_divide_middle = true,
                    globalstatus = true,
                    refresh = {
                        statusline = 1000,
                        tabline = 1000,
                        winbar = 1000,
                    },
                },
                sections = {
                    lualine_a = { 'mode', 'buffers' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = {},
                    lualine_x = { lsp_status.status(), 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'progress' },
                    lualine_z = { 'location' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = { 'lazy', 'nvim-tree' },
            })
        end,
    },
    {
        'nvim-tree/nvim-tree.lua',
        opts = {
            hijack_cursor = true,
            disable_netrw = false,
            hijack_netrw = true,
            view = {
                float = {
                    enable = true,
                    open_win_config = function()
                        local screen_w = vim.opt.columns:get()
                        local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                        local window_w = screen_w * WIDTH_RATIO
                        local window_h = screen_h * HEIGHT_RATIO
                        local window_w_int = math.floor(window_w)
                        local window_h_int = math.floor(window_h)
                        local center_x = (screen_w - window_w) / 2
                        local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                        return {
                            border = 'rounded',
                            relative = 'editor',
                            row = center_y,
                            col = center_x,
                            width = window_w_int,
                            height = window_h_int,
                        }
                    end,
                },
                width = function() return math.floor(vim.opt.columns:get() * WIDTH_RATIO) end,
            },
            diagnostics = { enable = true, show_on_dirs = true },
            modified = { enable = true },
            -- on_attach = require('keymap.plugins.nvim-tree')
        },
        init = function()
            -- vim.g.loaded_netrw = 1
            -- vim.g.loaded_netrwPlugin = 1
        end,
    },
    {
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {
            size = function(term)
                if term.direction == 'horizontal' then
                    return 15
                elseif term.direction == 'vertical' then
                    return vim.o.columns * 0.4
                end
            end,
            open_mapping = [[<c-\>]],
            hide_numbers = true, -- hide the number column in toggleterm buffers
        },
    },
    {
        'goolord/alpha-nvim',
        config = function()
            local alpha = require('alpha')
            local dashboard = require('alpha.themes.dashboard')

            dashboard.section.header.val = {
                [[                               __                ]],
                [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
                [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
                [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
                [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
                [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
            }
            dashboard.section.buttons.val = {
                dashboard.button('e', '  New file', '<cmd>ene <CR>'),
                dashboard.button('C-p', '󰈞  Find file', '<cmd>Telescope fd<CR>'),
                dashboard.button('SPC f r', '󰊄  Recently opened files', '<cmd>Telescope oldfiles <CR>'),
                dashboard.button('SPC f g', '󰈬  Find word'),
                dashboard.button('SPC s l', '  Open last session'),
            }

            require('alpha').setup(require('alpha.themes.dashboard').config)
        end,
    },
    {
        "hedyhli/outline.nvim",
        config = function()
            -- Example mapping to toggle outline
            vim.keymap.set("n", "<leader>o", "<cmd>Outline<CR>",
                { desc = "Toggle Outline" })

            require("outline").setup {
                -- Your setup opts here (leave empty to use defaults)
            }
        end,
    },
}
