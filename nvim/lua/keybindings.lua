---@diagnostic disable: undefined-global
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

-- File explorer
vim.api.nvim_set_keymap("n", "<Leader>ff", "<Cmd>Telescope find_files<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fb", "<Cmd>Telescope buffers<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fe", "<Cmd>Telescope diagnostics theme=ivy<CR>", opts)

-- Files (scoped)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>fa",
	"<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~') }<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>fr",
	"<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~/repos')}<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>fn",
	"<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~/Documents/Notes')}<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>fc",
	"<Cmd>lua require('telescope.builtin').find_files{ cwd = vim.fn.expand('~/.config')}<CR>",
	opts
)

-- Grep (all start with <Leader>g…)
vim.api.nvim_set_keymap("n", "<Leader>gg", "<Cmd>lua require('telescope.builtin').live_grep{ theme = 'ivy' }<CR>", opts) -- current cwd
vim.api.nvim_set_keymap(
	"n",
	"<Leader>ga",
	"<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~')}<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>gr",
	"<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~/repos')}<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>gn",
	"<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~/Documents/Notes')}<CR>",
	opts
)
vim.api.nvim_set_keymap(
	"n",
	"<Leader>gc",
	"<Cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.expand('~/.config')}<CR>",
	opts
)

vim.api.nvim_set_keymap("n", "<Leader>e", "<Cmd>Yazi<CR>", opts)

-- Obsidian.nvim keybindings
vim.api.nvim_set_keymap("n", "<Leader>od", "<Cmd>ObsidianToday<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>on", "<Cmd>ObsidianNewFromTemplate<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>oq", "<Cmd>ObsidianQuickSwitch<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ot", "<Cmd>ObsidianTemplate<CR>", opts)
vim.api.nvim_set_keymap("v", "<Leader>ol", "<Cmd>ObsidianLink<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ob", "<Cmd>ObsidianBacklinks<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>oe", "<Cmd>ObsidianExtractNote<CR>", opts)

-- Follow link under cursor (override gf within vault)
vim.keymap.set("n", "<CR>", function()
	if require("obsidian.util").cursor_on_markdown_link() then
		return "<Cmd>ObsidianFollowLink<CR>"
	else
		return "<CR>"
	end
end, { expr = true, noremap = true })

vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*",
	callback = function(args)
		require("conform").format({ bufnr = args.buf })
	end,
})

vim.api.nvim_set_keymap("n", "<leader>r", '<cmd>lua require("spectre").toggle()<CR>', {
	desc = "Toggle Spectre",
})
vim.api.nvim_set_keymap("n", "<leader>rw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
	desc = "Search current word",
})
vim.api.nvim_set_keymap("v", "<leader>rw", '<esc><cmd>lua require("spectre").open_visual()<CR>', {
	desc = "Search current word",
})
vim.api.nvim_set_keymap("n", "<leader>rp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
	desc = "Search on current file",
})

local builtin = require("telescope.builtin")

local ivy = { theme = "ivy" }

-- LSP pickers (<leader>l)
vim.keymap.set("n", "<leader>ld", function()
	builtin.lsp_definitions(ivy)
end, { desc = "LSP: definitions" })
vim.keymap.set("n", "<leader>lt", function()
	builtin.lsp_type_definitions(ivy)
end, { desc = "LSP: type definitions" })
vim.keymap.set("n", "<leader>li", function()
	builtin.lsp_implementations(ivy)
end, { desc = "LSP: implementations" })
vim.keymap.set("n", "<leader>ls", function()
	builtin.lsp_document_symbols(ivy)
end, { desc = "LSP: document symbols" })
vim.keymap.set("n", "<leader>lw", function()
	builtin.lsp_workspace_symbols(ivy)
end, { desc = "LSP: workspace symbols" })
vim.keymap.set("n", "<leader>ldw", function()
	builtin.lsp_dynamic_workspace_symbols(ivy)
end, { desc = "LSP: dynamic workspace symbols" })
vim.keymap.set("n", "<leader>lr", function()
	builtin.lsp_references(ivy)
end, { desc = "LSP: references" })
vim.keymap.set("n", "<leader>lic", function()
	builtin.lsp_incoming_calls(ivy)
end, { desc = "LSP: incoming calls" })
vim.keymap.set("n", "<leader>loc", function()
	builtin.lsp_outgoing_calls(ivy)
end, { desc = "LSP: outgoing calls" })

-- LSP → Quickfix (<leader>lq)
vim.keymap.set("n", "<leader>lq", function()
	vim.diagnostic.setqflist()
	vim.cmd("copen")
end, { desc = "LSP: diagnostics quickfix" })

-- Git pickers (<leader>g)
vim.keymap.set("n", "<leader>gc", function()
	builtin.git_commits(ivy)
end, { desc = "Git: commits" })
vim.keymap.set("n", "<leader>gs", function()
	builtin.git_status(ivy)
end, { desc = "Git: status" })
vim.keymap.set("n", "<leader>gf", function()
	builtin.git_files(ivy)
end, { desc = "Git: files" })
vim.keymap.set("n", "<leader>gst", function()
	builtin.git_stash(ivy)
end, { desc = "Git: stash" })

vim.keymap.set("n", "q", "<Nop>") -- disable macro recording key
vim.keymap.set("n", "<leader>qm", "q") -- <leader>qm to record macro
vim.keymap.set("n", "<leader>c", "<Cmd>Telescope command_history<CR>") -- <leader>qm to record macro

vim.keymap.set("n", "<leader>m", function()
	require("telescope.builtin").man_pages({ sections = { "*" } })
end, { desc = "All man pages" })

vim.keymap.set("n", "<leader>/", "<Cmd>Telescope search_history<CR>", {
	desc = "Search history",
})

vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "LSP: code action" })

vim.api.nvim_set_keymap("n", "<Leader>t", "<Cmd>Telescope <CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>fh", "<Cmd>Telescope help_tags<CR>", opts)
