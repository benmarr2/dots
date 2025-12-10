---@diagnostic disable: undefined-global
return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	},
	{
		"907th/vim-auto-save",
	},
	{
		"romgrk/barbar.nvim",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local themes = require("telescope.themes")

			telescope.setup({
				defaults = themes.get_ivy({
					layout_strategy = "bottom_pane",
					layout_config = { height = 0.6 },
				}),

				pickers = {
					-- find_files = { theme = "dropdown" },
				},
			})
		end,
	},
	{
		"elkowar/yuck.vim",
	},
	{
		"sainnhe/gruvbox-material",
	},
	{
		"ggandor/leap.nvim",
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- use latest release
		lazy = true,
		ft = "markdown", -- load only for Markdown files
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	-- Mason: multi-language-server installer UI
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = function()
			require("mason").setup()
		end,
	},

	-- Mason + lspconfig bridge (auto-installs LSPs you configure)
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "clangd", "bashls" },
			})
		end,
	},

	-- Core LSP client configurations
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			local function set_float_highlights()
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
				vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#b8bb26", bg = "none" })
			end

			set_float_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_float_highlights,
			})

			local float_opts = {
				border = "single",
				max_width = 80,
				max_height = 20,
			}

			vim.diagnostic.config({
				float = float_opts,
			})

			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

			vim.o.updatetime = 250

			local on_attach = function(_, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)

				-- Show diagnostics for the current line only when you press "?"
				vim.keymap.set("n", "?", function()
					vim.diagnostic.open_float(nil, { focusable = true })
				end, opts)
			end

			local caps = vim.lsp.protocol.make_client_capabilities()
			caps = require("cmp_nvim_lsp").default_capabilities(caps)

			lspconfig.pyright.setup({ on_attach = on_attach, capabilities = caps })
			lspconfig.clangd.setup({ on_attach = on_attach, capabilities = caps })
			lspconfig.bashls.setup({ on_attach = on_attach, capabilities = caps })
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			local cmp = require("cmp")

			local function set_cmp_highlights()
				vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "none" })
				vim.api.nvim_set_hl(0, "CmpPmenuBorder", { fg = "#b8bb26", bg = "none" })
				vim.api.nvim_set_hl(0, "CmpPmenuSel", { bg = "#b8bb26", fg = "#1d2021" })
			end

			set_cmp_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_cmp_highlights,
			})

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered({
						border = "single",
						max_width = 60,
						max_height = 15,
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "single",
						max_width = 80,
						max_height = 20,
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None",
					}),
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-j>"] = cmp.mapping.scroll_docs(4),
					["<C-k>"] = cmp.mapping.scroll_docs(-4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping.confirm({ select = true }),
				}),
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
					{ name = "path" },
				},
				formatting = {
					fields = { "abbr", "menu", "kind" },
					format = function(entry, item)
						-- Define menu shorthand for different completion sources.
						local menu_icon = {
							nvim_lsp = "NLSP",
							nvim_lua = "NLUA",
							luasnip = "LSNP",
							buffer = "BUFF",
							path = "PATH",
						}
						-- Set the menu "icon" to the shorthand for each completion source.
						item.menu = menu_icon[entry.source.name]

						-- Set the fixed width of the completion menu to 60 characters.
						-- fixed_width = 20

						-- Set 'fixed_width' to false if not provided.
						fixed_width = fixed_width or false

						-- Get the completion entry text shown in the completion window.
						local content = item.abbr

						-- Set the fixed completion window width.
						if fixed_width then
							vim.o.pumwidth = fixed_width
						end

						-- Get the width of the current window.
						local win_width = vim.api.nvim_win_get_width(0)

						-- Set the max content width based on either: 'fixed_width'
						-- or a percentage of the window width, in this case 20%.
						-- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
						local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

						-- Truncate the completion entry text if it's longer than the
						-- max content width. We subtract 3 from the max content width
						-- to account for the "..." that will be appended to it.
						if #content > max_content_width then
							item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
						else
							item.abbr = content .. (" "):rep(max_content_width - #content)
						end
						return item
					end,
				},
			})

			vim.o.completeopt = "menu,menuone,noselect"
			vim.opt.shortmess:append("c")

			vim.keymap.set("i", "<C-n>", "<Nop>", { silent = true })
			vim.keymap.set("i", "<C-p>", "<Nop>", { silent = true })
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("colorizer").setup({ "*" }, {
				RRGGBBAA = true,
				RRGGBB = true,
				names = true,
				RGB = true,
				css = true,
				css_fn = true,
			})
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"mikavilpas/yazi.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			-- your existing keybinding style
			{
				"<leader>e",
				"<cmd>Yazi<cr>",
				desc = "Open yazi file manager",
				mode = { "n", "v" },
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- core behaviour
			open_for_directories = false,
			change_neovim_cwd_on_close = true,
			-- make the float behave like fullscreen & non-fancy
			floating_window_scaling_factor = 1.0, -- 100% of the editor
			yazi_floating_window_border = "none", -- no rounded border
			yazi_floating_window_winblend = 0, -- no transparency
			yazi_floating_window_zindex = 50, -- sit “on top” of other floats

			-- optional: keep the default keymaps
			keymaps = {
				show_help = "<f1>",
			},
		},
	},

	-- lazy.nvim plugin spec
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()

			-- Remap: <leader>/ to toggle comment for current line or selection
			vim.keymap.set("n", "<leader>/", function()
				require("Comment.api").toggle.linewise.current()
			end, { desc = "Toggle comment (line)" })

			vim.keymap.set("v", "<leader>/", function()
				-- Get visual mode range
				local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
				vim.api.nvim_feedkeys(esc, "nx", false)
				require("Comment.api").toggle.linewise(vim.fn.visualmode())
			end, { desc = "Toggle comment (visual selection)" })
		end,
	},
	{
		"sphamba/smear-cursor.nvim",

		opts = {
			-- Smear cursor when switching buffers or windows.
			smear_between_buffers = true,

			-- Smear cursor when moving within line or to neighbor lines.
			-- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
			smear_between_neighbor_lines = true,

			-- Draw the smear in buffer space instead of screen space when scrolling
			scroll_buffer_space = true,

			-- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
			-- Smears will blend better on all backgrounds.
			legacy_computing_symbols_support = false,

			-- Smear cursor in insert mode.
			-- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
			smear_insert_mode = true,
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"nvim-pack/nvim-spectre",
	},
}
