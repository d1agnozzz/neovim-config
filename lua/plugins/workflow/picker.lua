return {
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
    {
        'folke/snacks.nvim',
        lazy = false,
        priority = 1000,
        ---@type snacks.Config
        opts = {
            picker = {
                enabled = true,
            },
        },
        keys = {
            { '<leader>p', function() Snacks.picker.smart() end, desc = 'Smart find files' },
            {
                '<leader>,',
                function()
                    Snacks.picker.buffers({
                        focus = 'list',
                        layout = {
                            preset = 'ivy',
                        },
                    })
                end,
                desc = 'List buffers',
            },
            {
                '<leader>fg',
                function() Snacks.picker.grep() end,
                desc = 'Grep picker',
            },
            {
                '<leader>fh',
                function() Snacks.picker.help() end,
                desc = 'Help pages picker',
            },
            {
                '<leader>u',
                function() Snacks.picker.undo() end,
                desc = 'Undo tree picker',
            },
        },
    },
}
