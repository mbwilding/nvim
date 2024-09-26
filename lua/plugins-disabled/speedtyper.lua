return {
    "NStefan002/speedtyper.nvim",
    cmd = "Speedtyper",
    config = function()
        require("speedtyper").setup({})

        vim.keymap.set("n", "<leader>mt", "<CMD>Speedtyper<CR>", { desc = "SpeedTyper" })
    end,
}
