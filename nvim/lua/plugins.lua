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
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local telescope = require("telescope")
    local themes = require("telescope.themes")

    telescope.setup({
      defaults = themes.get_ivy({
        layout_strategy = ("bottom_pane"),
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
    floating_window_scaling_factor = 1.0,  -- 100% of the editor
    yazi_floating_window_border = "none",  -- no rounded border
    yazi_floating_window_winblend = 0,     -- no transparency
    yazi_floating_window_zindex = 50,      -- sit “on top” of other floats

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
  end
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
 }
}

