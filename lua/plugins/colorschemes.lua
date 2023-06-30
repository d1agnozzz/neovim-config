local colorchemes = {
    { 'morhetz/gruvbox' },
    { 'rebelot/kanagawa.nvim' },
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
