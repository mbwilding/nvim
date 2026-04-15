vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = {
        "*.bin",
    },
    once = true,
    callback = function()
        vim.schedule(function()
            vim.cmd("Hex")
        end)
    end,
})

return {
    "DamianVCechov/hexview.nvim",
    opts = {},
}
