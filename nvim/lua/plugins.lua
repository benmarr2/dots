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
		init = function()
			vim.g.barbar_auto_setup = false
		end,
		opts = {
			icons = {
				preset = "default",
				separator = { left = "", right = "" },
			},
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
			require("mason").setup({
				registries = {
					"github:mason-org/mason-registry",
					"github:Crashdummyy/mason-registry",
				},
			})
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
			local function has_attached_lsp(bufnr)
				return not vim.tbl_isempty(vim.lsp.get_clients({ bufnr = bufnr }))
			end

			local function lsp_definition()
				local bufnr = vim.api.nvim_get_current_buf()
				if not has_attached_lsp(bufnr) then
					vim.notify("No LSP is attached to this buffer", vim.log.levels.WARN)
					return
				end
				vim.lsp.buf.definition()
			end

			local function lsp_hover()
				local bufnr = vim.api.nvim_get_current_buf()
				if has_attached_lsp(bufnr) then
					vim.lsp.buf.hover()
					return
				end
				vim.notify("No LSP is attached to this buffer", vim.log.levels.WARN)
			end

			local function lsp_signature_help()
				local bufnr = vim.api.nvim_get_current_buf()
				if not has_attached_lsp(bufnr) then
					vim.notify("No LSP is attached to this buffer", vim.log.levels.WARN)
					return
				end
				vim.lsp.buf.signature_help()
			end

			local function set_float_highlights()
				vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
				vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#b8bb26", bg = "none" })
			end

			set_float_highlights()
			vim.api.nvim_create_autocmd("ColorScheme", { callback = set_float_highlights })

			local float_opts = {
				border = "single",
				max_width = 80,
				max_height = 20,
			}

			vim.diagnostic.config({ float = float_opts })
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_opts)
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_opts)

			vim.o.updatetime = 250

			vim.keymap.set("n", "gd", lsp_definition, { noremap = true, silent = true, desc = "LSP: go to definition" })
			vim.keymap.set("n", "K", lsp_hover, { noremap = true, silent = true, desc = "LSP: hover" })
			vim.keymap.set(
				"n",
				"<C-k>",
				lsp_signature_help,
				{ noremap = true, silent = true, desc = "LSP: signature help" }
			)

			local function lsp_keymaps(bufnr)
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "?", function()
					vim.diagnostic.open_float(nil, { focusable = true })
				end, opts)
			end

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					lsp_keymaps(args.buf)
				end,
			})

			local caps = vim.lsp.protocol.make_client_capabilities()
			caps = require("cmp_nvim_lsp").default_capabilities(caps)

			vim.lsp.config("pyright", { capabilities = caps })
			vim.lsp.config("clangd", { capabilities = caps })
			vim.lsp.config("bashls", { capabilities = caps })
			vim.lsp.enable({ "pyright", "clangd", "bashls" })
			vim.lsp.enable("omnisharp", false)
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
						max_width = math.floor(vim.o.columns * 0.4),
						max_height = 15,
						winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None",
					}),
					documentation = cmp.config.window.bordered({
						border = "single",
						max_width = math.floor(vim.o.columns * 0.4),
						max_height = 15,
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

						local max_abbr = 30
						local content = item.abbr
						if #content > max_abbr then
							item.abbr = vim.fn.strcharpart(content, 0, max_abbr - 3) .. "..."
						else
							item.abbr = content .. (" "):rep(max_abbr - #content)
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
			smear_between_buffers = true,
			smear_between_neighbor_lines = true,
			scroll_buffer_space = true,
			legacy_computing_symbols_support = false,
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {},
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			dapui.setup()

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"mfussenegger/nvim-dap",
		},
	},
	{
		"seblyng/roslyn.nvim",
		---@module 'roslyn.config'
		---@type RoslynNvimConfig
		opts = {},
		config = function(_, opts)
			local caps = vim.lsp.protocol.make_client_capabilities()
			caps = require("cmp_nvim_lsp").default_capabilities(caps)

			vim.lsp.config("roslyn", {
				capabilities = caps,
			})

			require("roslyn").setup(opts)
		end,
	},
}
