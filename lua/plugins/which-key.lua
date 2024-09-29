return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        delay = 1000,
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Which-Key: Buffer Local Keymaps",
        },
    },
}
