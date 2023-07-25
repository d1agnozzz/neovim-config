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
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'auto'

vim.opt.updatetime = 100

vim.opt.colorcolumn = '80,100'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hidden = true

vim.opt.listchars = "trail:·,nbsp:·,extends:>,precedes:<,eol:↲"

vim.opt.spell = true
vim.opt.spelllang = 'en,ru'
vim.cmd('augroup SpellBadHighlight')
vim.cmd('autocmd!')
vim.cmd('autocmd ColorScheme * highlight SpellBad cterm=undercurl gui=undercurl guisp=green')
vim.cmd('augroup END')
