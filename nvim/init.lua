-- LAZY -- 
vim.g.mapleader = " " 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")
-- LAZY --
require("treesitter")

require("settings")
require("keybindings")

vim.g.vimwiki_list = {{
  path = '~/Documents/notes/',
  syntax = 'markdown',
  ext = '.md'
}}
vim.g.vimwiki_ext2syntax = { ['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown' }

vim.g.taskwiki_markup_syntax = 'markdown'
