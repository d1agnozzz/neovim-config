return{
    { 'ms-jpq/coq_nvim', branch = 'coq', config = function()
            vim.cmd('COQnow --shut-up')
        end
    },
    { 'ms-jpq/coq.artifacts', branch = 'artifacts' },
    { 'ms-jpq/coq.thirdparty', branch = '3p' },
    { 'numToStr/Comment.nvim', opts = {} },
    { 'kylechui/nvim-surround', event = 'VeryLazy', opts = {} },
    { 'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
}

