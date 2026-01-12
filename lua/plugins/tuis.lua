return {
    "jrop/tuis.nvim",
    config = function()
        -- Optional: set up keymaps
        vim.keymap.set("n", "<leader>\\", function()
            require("tuis").choose()
        end, { desc = "TUIs" })
    end,
}
