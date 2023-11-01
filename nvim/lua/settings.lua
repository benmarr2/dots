vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.wrap = true

vim.cmd('set noswapfile')
vim.cmd('set expandtab')
vim.cmd('set autochdir')
vim.cmd('set encoding=utf-8')

vim.g.gruvbox_contrast_dark = "hard"
vim.cmd([[colorscheme gruvbox]])
