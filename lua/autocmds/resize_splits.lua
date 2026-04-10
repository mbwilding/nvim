vim.api.nvim_create_autocmd("VimResized", {
    group = vim.api.nvim_create_augroup("resize_splits", { clear = true }),
    command = "wincmd =",
})
