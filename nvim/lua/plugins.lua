return {
	{
		"morhetz/gruvbox",
	},
	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
	},
	{
		"vimwiki/vimwiki",
		init = function()
			vim.g.vimwiki_markdown_link_ext = 1
			vim.g.vimwiki_list = {
				{
					path = "/home/benmarr/Documents/vimwiki/",
					syntax = "markdown",
					ext = ".md",
				},
			}
		end,
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
		options = { theme = "gruvbox" },
	},
	{
		"907th/vim-auto-save",
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
			"nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
		},
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			-- animation = true,
			-- insert_at_start = true,
			-- …etc.
		},
		version = "^1.0.0",
	},
	{
		"nvim-telescope/telescope.nvim",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	--LSP SUTFF
	{
		"neovim/nvim-lspconfig",
	},
	{
		"williamboman/mason.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"saadparwaiz1/cmp_luasnip",
	},
	{
		"L3MON4D3/LuaSnip",
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			-- add any options here
		},
		lazy = false,
	},
	{
		"sbdchd/neoformat",
	},
}
