local cursorPreAction
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("yank_cursor", { clear = true }),
    callback = function()
        if vim.v.event.operator == "y" and cursorPreAction then
            vim.api.nvim_win_set_cursor(0, cursorPreAction)
        end
    end,
})
