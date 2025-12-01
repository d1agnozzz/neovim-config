local colorchemes = {
    { 'effkay/argonaut.vim' },
    {
        'sainnhe/gruvbox-material',
        config = function()
            vim.g.gruvbox_material_background = 'hard'
            vim.g.gruvbox_material_foreground = 'material'
            vim.g.gruvbox_material_enable_bold = '1'
            vim.g.gruvbox_material_enable_italic = '1'
        end,
    },
    -- { 'morhetz/gruvbox' },
{
        'rebelot/kanagawa.nvim',
        opts = {
            colors = {
                theme = {
                    all = {
                        ui = {
                            bg_gutter = 'none', -- Remove the background of LineNr, {Sign,Fold}Column and friends
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
                    MatchParen = { bg = '#54546D' }, -- gray background for matching parentheses
                }
            end,
        },
    }, -- eilfji ( w,eflihf )
    { 'Shatur/neovim-ayu' },
    -- { 'ayu-theme/ayu-vim',
    --     config = function()
    --         ayucolor = 'light'
    --     end
    -- },
    { 'folke/tokyonight.nvim' },
    { 'EdenEast/nightfox.nvim' },
    { 'talha-akram/noctis.nvim' },
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
    { 'diegoulloao/neofusion.nvim', priority = 1000, config = true, opts = ... },
    { 'yorumicolors/yorumi.nvim' },
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
