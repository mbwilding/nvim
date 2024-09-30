return {
    {
        "ramilito/kubectl.nvim",
        enabled = vim.fn.has("win32") == 0,
        config = function()
            require("kubectl").setup()

            vim.keymap.set("n", "<leader>k", function()
                require("kubectl").toggle()
            end, { desc = "Kubectl" })
        end,
    },
}
