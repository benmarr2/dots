-- ────────────────────────────────────────────────────────────────────────────
--  Basic options (yours)
vim.opt.shiftwidth       = 2
vim.opt.tabstop          = 2
vim.opt.expandtab        = true
vim.opt.number           = true
vim.opt.relativenumber   = true
vim.opt.ignorecase       = true
vim.opt.termguicolors    = true
vim.opt.scrolloff        = 8
vim.opt.wrap             = true
vim.g.auto_save          = 0
vim.opt.clipboard        = "unnamedplus"
vim.opt.colorcolumn      = "120"
vim.cmd("set noswapfile")
vim.cmd("set autochdir")
vim.cmd("set encoding=utf-8")
vim.cmd("set nohlsearch")

-- ────────────────────────────────────────────────────────────────────────────
--  Colourscheme
vim.o.background = "dark"
vim.g.gruvbox_material_background = "hard"
vim.g.gruvbox_material_foreground = "original"
vim.g.gruvbox_material_enable_italic = true
vim.g.gruvbox_material_better_performance = 1
vim.cmd.colorscheme("gruvbox-material")

-- ────────────────────────────────────────────────────────────────────────────
--  Netrw configuration
vim.g.netrw_banner            = 0      -- no intro text
vim.g.netrw_liststyle         = 3      -- tree-style
vim.g.netrw_browse_split      = 0      -- close netrw after opening a file
vim.g.netrw_winsize           = 20     -- height of the split (in lines)
vim.g.netrw_localcopydircmd   = 'cp -r'
vim.g.netrw_keepdir           = 0      -- don't keep CWD in netrw
vim.cmd([[ let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro' ]])
vim.cmd([[ hi! link netrwMarkFile Search ]])  -- correct way to link highlight

-- ────────────────────────────────────────────────────────────────────────────
--  Obsidian
vim.opt.conceallevel = 1
