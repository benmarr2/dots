local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap('n', '<S-h>', '<Cmd>BufferPrevious<CR>', opts)
vim.api.nvim_set_keymap('n', '<S-l>', '<Cmd>BufferNext<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-h>', '<Cmd>BufferMovePrevious<CR>', opts)
vim.api.nvim_set_keymap('n', '<A-l>', '<Cmd>BufferMoveNext<CR>', opts)
vim.api.nvim_set_keymap('n', '<Leader>x', '<Cmd>BufferClose<CR>', opts)
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', opts)
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', opts)

vim.api.nvim_set_keymap('n', '<leader>e', 'Telescope file_browser<CR>', opts)
