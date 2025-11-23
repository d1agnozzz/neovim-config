return {
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
}
