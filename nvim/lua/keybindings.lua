local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-h>", "<Cmd>BufferMovePrevious<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-l>", "<Cmd>BufferMoveNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>x", "<Cmd>BufferClose<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "<C-Right>", "<Cmd>vertical resize -5<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Left>", "<Cmd>vertical resize +5<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-w>", "3w", opts)
vim.api.nvim_set_keymap("n", "<S-e>", "3e", opts)

vim.api.nvim_set_keymap("n", "<Leader>fg", "<Cmd>Telescope live_grep theme=ivy<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fb", "<Cmd>Telescope buffers theme=ivy<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ff", "<Cmd>Telescope find_files theme=ivy<CR>", opts)

vim.api.nvim_set_keymap("n", "<Leader>e", "<Cmd>Explore<CR>", opts)
