local colorchemes = {
    { 'sainnhe/gruvbox-material' },
    { 'morhetz/gruvbox' },
    {
        'rebelot/kanagawa.nvim',
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = 'none',
                        },
                    },
                },
            },

            overrides = function(colors)
                local theme = colors.theme
                return {
                    Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
                    PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
                    PmenuSbar = { bg = theme.ui.bg_m1 },
                    PmenuThumb = { bg = theme.ui.bg_p2 },
                }
            end,
        },
    },
    {'Shatur/neovim-ayu'},
    { 'folke/tokyonight.nvim' },
    { 'EdenEast/nightfox.nvim' },
    { 'sainnhe/sonokai' },
    { 'dracula/vim' },
    { 'loctvl842/monokai-pro.nvim', opts = {} },
    { 'ellisonleao/gruvbox.nvim', opts = {} },
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'catppuccin/nvim', name = 'catppuccin' },
    { 'ViViDboarder/wombat.nvim', dependencies = { 'rktjmp/lush.nvim' } },
    {
        'navarasu/onedark.nvim',
        config = function()
            require('onedark').setup({
                style = 'warmer',
            })
        end,
    },
}

local function colorschemes_change_priority(lazy_specs)
    for _, v in ipairs(lazy_specs) do
        v.priority = 1000
        -- if not string.find(v[1], Current_colorscheme) then
        --     v.lazy = true
        -- end
    end
end

colorschemes_change_priority(colorchemes)

return colorchemes
