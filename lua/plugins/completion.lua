return{
    { 'numToStr/Comment.nvim', opts = {} },
    { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {--[[ map_bs = false, map_cr = false ]]},
    },
}

