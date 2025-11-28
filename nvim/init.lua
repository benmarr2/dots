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
require("telescope").setup()
require("settings")
require("lualine").setup()
require('leap').set_default_mappings()
require('obsidian').setup(opts.obsidian_opts)
require("keybindings")

local from_terminal = vim.loop.os_getenv("NVIM_PICKER_PROFILE") == "terminal"

if from_terminal then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "TelescopePrompt",
    once = true,
    callback = function(args)
      vim.schedule(function()
        for _, win in ipairs(vim.api.nvim_list_wins()) do
          if vim.api.nvim_win_get_buf(win) == args.buf then
            vim.api.nvim_set_current_win(win)
            break
          end
        end
      end)
    end,
  })
end


vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("YankHighlight", {}),
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch", -- highlight group
      timeout = 200,         -- duration in ms
    })
  end,
})
