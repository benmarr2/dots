local M = {}

M.obsidian_opts = {
	workspaces = {
		{
			name = "personal",
			path = "~/Documents/Notes",
		},
	},
	daily_notes = {
		folder = "00_Diary",
		date_format = "%d-%b-%Y",
		template = "daily.md",
	},
	templates = {
		folder = "03_Templates",
	},
	disable_frontmatter = true,
	follow_url_func = function(url)
		vim.ui.open(url) -- Neovim 0.10+
		-- vim.fn.jobstart({"xdg-open", url}) -- Linux fallback
		-- vim.fn.jobstart({"open", url})     -- macOS fallback
	end,
	follow_img_func = function(img)
		vim.ui.open(img)
	end,
}

return M
