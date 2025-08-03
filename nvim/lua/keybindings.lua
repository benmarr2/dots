local opts = { noremap = true, silent = true }

-- Buffer navigation
vim.api.nvim_set_keymap("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-h>", "<Cmd>BufferMovePrevious<CR>", opts)
vim.api.nvim_set_keymap("n", "<A-l>", "<Cmd>BufferMoveNext<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>x", "<Cmd>BufferClose<CR>", opts)

-- Window navigation & resizing
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", opts)
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", opts)
vim.api.nvim_set_keymap("n", "<C-Right>", "<Cmd>vertical resize -5<CR>", opts)
vim.api.nvim_set_keymap("n", "<C-Left>", "<Cmd>vertical resize +5<CR>", opts)
vim.api.nvim_set_keymap("n", "<S-w>", "3w", opts)
vim.api.nvim_set_keymap("n", "<S-e>", "3e", opts)

-- Telescope
vim.api.nvim_set_keymap("n", "<Leader>fg", "<Cmd>Telescope live_grep theme=ivy<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fb", "<Cmd>Telescope buffers theme=ivy<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ff", "<Cmd>Telescope find_files theme=ivy<CR>", opts)

-- File explorer
vim.api.nvim_set_keymap("n", "<Leader>e", "<Cmd>Explore<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>E", "<Cmd>Rex<CR>", opts)

-- Obsidian.nvim keybindings

-- Open or create today's daily note
vim.api.nvim_set_keymap('n', '<Leader>ot', "<Cmd>ObsidianToday<CR>", opts)
-- Insert a template into current note
vim.api.nvim_set_keymap('n', '<Leader>on', "<Cmd>ObsidianNewFromTemplate<CR>", opts)
-- Quick switch between notes
vim.api.nvim_set_keymap('n', '<Leader>oq', "<Cmd>ObsidianQuickSwitch<CR>", opts)

-- Follow link under cursor (override gf within vault)
vim.keymap.set('n', '<CR>', function()
  if require('obsidian.util').cursor_on_markdown_link() then
    return '<Cmd>ObsidianFollowLink<CR>'
  else
    return '<CR>'
  end
end, { expr = true, noremap = true })
