vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("line_endings", { clear = true }),
    pattern = { "sh", "make", "zsh", "bash", "fish", "gitconfig", "tmux" },
    command = "set fileformat=unix",
})
