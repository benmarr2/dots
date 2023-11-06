return{
    {
        "morhetz/gruvbox"
    },
    {
        "nvim-treesitter/nvim-treesitter", 
        run = ":TSUpdate"
    },
    {
        "vimwiki/vimwiki",
        init = function()
            vim.g.vimwiki_markdown_link_ext = 1
            vim.g.vimwiki_list = {{
              path = '/home/benmarr/Documents/vimwiki/',
              syntax = 'markdown',
              ext = '.md',
            }}
        end
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
      'nvim-lualine/lualine.nvim',
      requires = { 'nvim-tree/nvim-web-devicons', opt = true },
      options = { theme = 'gruvbox'},
    },
    {
        '907th/vim-auto-save'
    },
}
