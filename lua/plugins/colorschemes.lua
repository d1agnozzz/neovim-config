local colorchemes = {
    { 'morhetz/gruvbox' },
    { 'rebelot/kanagawa.nvim' },
    { 'folke/tokyonight.nvim' },
    { 'EdenEast/nightfox.nvim' },
    { 'sainnhe/sonokai' },
    { 'ellisonleao/gruvbox.nvim', opts = {} },
    { 'rose-pine/neovim', name = 'rose-pine' },
    { 'catppuccin/nvim', name = 'catppuccin' },
    { 'ViViDboarder/wombat.nvim', dependencies = { 'rktjmp/lush.nvim', }, },
    { 'navarasu/onedark.nvim', config = function()
    require('onedark').setup {
        style = 'warmer'
    }
    end
    },
}

local function colorschemes_change_priority(lazy_specs)
    for i, v in ipairs(lazy_specs) do
       v.priority = 1000 
    end
end

colorschemes_change_priority(colorchemes)

return colorchemes
