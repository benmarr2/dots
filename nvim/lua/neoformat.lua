-- Neoformat configuration
vim.g.neoformat_c_clangformat = {
    exe = "clang-format",
    args = {"-style=file"}
}

vim.g.neoformat_enabled_cpp = {"clangformat"}
vim.g.neoformat_enabled_c = {"clangformat"}

