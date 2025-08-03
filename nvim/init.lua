-- leader should be set before loading lazy
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

local opts = require("opts")
require("treesitter")
-- require("telescope").setup()
-- require("telescope").load_extension("fzf")
require("settings")
require("lualine").setup()
require('leap').set_default_mappings()
require('obsidian').setup(opts.obsidian_opts)
require("keybindings")
