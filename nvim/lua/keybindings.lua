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

-- TELESCOPE
-- Files (general)
vim.api.nvim_set_keymap("n", "<Leader>ff", "<Cmd>Telescope find_files theme=ivy<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fb", "<Cmd>Telescope buffers theme=ivy<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fe", "<Cmd>Telescope diagnostics theme=ivy<CR>", opts)

-- Files (scoped)
vim.api.nvim_set_keymap("n", "<Leader>fa", "<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~'), theme = 'ivy' }<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fr", "<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~/repos'), theme = 'ivy' }<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fn", "<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~/Documents/Notes'), theme = 'ivy' }<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fc", "<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~/.config'), theme = 'ivy' }<CR>", opts)

-- Grep (all start with <Leader>g…)
vim.api.nvim_set_keymap("n", "<Leader>gg", "<Cmd>lua require('telescope.builtin').live_grep{ theme = 'ivy' }<CR>", opts) -- current cwd
vim.api.nvim_set_keymap("n", "<Leader>ga", "<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~'), theme = 'ivy' }<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>gr", "<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~/repos'), theme = 'ivy' }<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>gn", "<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~/Documents/Notes'), theme = 'ivy' }<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>gc", "<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~/.config'), theme = 'ivy' }<CR>", opts)
-- File explorer
vim.api.nvim_set_keymap("n", "<Leader>e", "<Cmd>Yazi<CR>", opts)

-- Obsidian.nvim keybindings
vim.api.nvim_set_keymap('n', '<Leader>ot', "<Cmd>ObsidianToday<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>on', "<Cmd>ObsidianNewFromTemplate<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>oq', "<Cmd>ObsidianQuickSwitch<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>ot', "<Cmd>ObsidianTemplate<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>ol', "<Cmd>ObsidianLink<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>ob', "<Cmd>ObsidianBacklinks<CR>", opts)
vim.api.nvim_set_keymap('n', '<Leader>oe', "<Cmd>ObsidianExtractNote<CR>", opts)

-- Follow link under cursor (override gf within vault)
vim.keymap.set('n', '<CR>', function()
  if require('obsidian.util').cursor_on_markdown_link() then
    return '<Cmd>ObsidianFollowLink<CR>'
  else
    return '<CR>'
  end
end, { expr = true, noremap = true })
