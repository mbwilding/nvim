vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("comment_vhs", { clear = true }),
    pattern = "vhs",
    callback = function()
        vim.bo.commentstring = "# %s"
    end,
})
