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
}
