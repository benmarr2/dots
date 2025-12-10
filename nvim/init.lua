---@diagnostic disable: undefined-global
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
require("leap").set_default_mappings()
require("obsidian").setup(opts.obsidian_opts)

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		rust = { "rustfmt", lsp_format = "fallback" },
		javascript = { "prettierd", "prettier", stop_after_first = true },
		c = { "clang_format" },
		cpp = { "clang_format" },
	},
})
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
			timeout = 200, -- duration in ms
		})
	end,
})

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

-- state: whether hidden files are currently enabled
local telescope_show_hidden = false

local function toggle_hidden(prompt_bufnr)
	-- close current picker
	actions.close(prompt_bufnr)

	-- flip the flag
	telescope_show_hidden = not telescope_show_hidden

	-- reopen find_files with new settings
	builtin.find_files({
		hidden = telescope_show_hidden,
		no_ignore = telescope_show_hidden,
	})
end

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<C-h>"] = toggle_hidden, -- insert mode
			},
			n = {
				["<C-h>"] = toggle_hidden, -- normal mode
			},
		},
	},
	pickers = {
		diagnostics = {
			theme = "ivy",
			-- no attach_mappings override, so <CR> just jumps as normal
		},
	},
})
require("spectre").setup()

local orig_signs = vim.diagnostic.handlers.signs

vim.diagnostic.handlers.signs = {
	show = function(namespace, bufnr, diagnostics, opts) -- pick the worst severity per line
		local max_severity_per_line = {}
		for _, d in ipairs(diagnostics) do
			local lnum = d.lnum
			local best = max_severity_per_line[lnum]
			if not best or d.severity < best.severity then
				max_severity_per_line[lnum] = d
			end
		end

		local filtered = {}
		for _, d in pairs(max_severity_per_line) do
			table.insert(filtered, d)
		end

		-- call the original handler with the filtered list
		orig_signs.show(namespace, bufnr, filtered, opts)
	end,

	hide = function(namespace, bufnr)
		orig_signs.hide(namespace, bufnr)
	end,
}
vim.diagnostic.config({
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "",
			[vim.diagnostic.severity.WARN] = "",
			[vim.diagnostic.severity.INFO] = "",
			[vim.diagnostic.severity.HINT] = "",
		},
		-- optional: number highlight
		numhl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
})

-- Open file under cursor (like in markdown links) in a new tab
vim.keymap.set("n", "gt", function()
	local file = vim.fn.expand("<cfile>")
	if file == "" then
		vim.notify("No file under cursor", vim.log.levels.WARN)
		return
	end
	vim.cmd("tabedit " .. vim.fn.fnameescape(file))
end, { desc = "Open file under cursor in new tab" })
