vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.ignorecase = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.wrap = true

vim.cmd("set noswapfile")
vim.cmd("set expandtab")
vim.cmd("set autochdir")
vim.cmd("set encoding=utf-8")
vim.cmd("set colorcolumn=80")
vim.cmd("set nohlsearch")

vim.g.auto_save = 0
vim.g.gruvbox_contrast_dark = "hard"

vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".markdown"] = "markdown", [".mdown"] = "markdown" }

vim.cmd([[colorscheme gruvbox]])

vim.api.nvim_exec(
	[[
augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
augroup END
]],
	false
)
