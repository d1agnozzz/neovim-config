vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = 'auto'

vim.opt.updatetime = 100

vim.opt.colorcolumn = '80,100'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hidden = true

vim.opt.listchars = 'trail:·,nbsp:·,extends:>,precedes:<,eol:↲'

vim.opt.spell = true
vim.opt.spelllang = 'en,ru'
vim.cmd('augroup SpellBadHighlight')
vim.cmd('autocmd!')
vim.cmd('autocmd ColorScheme * highlight SpellBad cterm=undercurl gui=undercurl guisp=green')
vim.cmd('augroup END')

vim.opt.fileencodings:append({ 'cp1251' })

vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldmethod = 'expr'

-- vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldexpr = vim.lsp.foldexpr and 'v:lua.vim.lsp.foldexpr()' or 'v:lua.vim.treesitter.foldexpr()'
vim.o.foldtext = ''
vim.opt.foldcolumn = '0'
vim.opt.fillchars:append({ fold = ' ' })

-- vim.opt.autochdir = true

-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- vim.api.nvim_create_augroup('OpenAllFolds', {})
-- vim.api.nvim_create_autocmd({ 'BufReadPost', 'FileReadPost' }, {
--     group = 'OpenAllFolds',
--     command = 'normal zR',
-- })
