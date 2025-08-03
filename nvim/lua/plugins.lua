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
		}
	},
	{
		"nvim-telescope/telescope.nvim",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{
		"elkowar/yuck.vim",
	},
  {
    "sainnhe/gruvbox-material"
  },
  {
    "ggandor/leap.nvim"
  },
  {
    "epwalsh/obsidian.nvim",
    version = "*",      -- use latest release
    lazy = true,
    ft = "markdown",    -- load only for Markdown files
    dependencies = {
      "nvim-lua/plenary.nvim",
    }
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

      -- shared on_attach and capabilities
      local on_attach = function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        -- …add any mappings you like…
      end

      local caps = vim.lsp.protocol.make_client_capabilities()
      caps = require("cmp_nvim_lsp").default_capabilities(caps)

      -- Individual server setup
      lspconfig.pyright.setup { on_attach = on_attach, capabilities = caps }
      lspconfig.clangd .setup { on_attach = on_attach, capabilities = caps }
      lspconfig.bashls .setup { on_attach = on_attach, capabilities = caps }
      -- …add more servers as desired…
    end,
  },

  -- (Optionally) nvim-cmp for completion integration
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
      cmp.setup({
        snippet = {
          expand = function(args) require("luasnip").lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]     = cmp.mapping.confirm({ select = true }),
        }),
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer"   },
          { name = "path"     },
        },
      })
    end,
  },
  {
    'norcalli/nvim-colorizer.lua',
    event = { 'BufReadPost', 'BufNewFile' },
    config = function()
      require('colorizer').setup(
        { '*' },
        {
          RRGGBBAA = true,
          RRGGBB   = true,
          names    = true,
          RGB      = true,
          css      = true,
          css_fn   = true,
        }
      )
    end,
  },
}

