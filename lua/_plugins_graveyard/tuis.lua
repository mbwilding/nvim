return {
    "jrop/tuis.nvim",
    lazy = true,
    keys = {
        {
            "<leader>\\",
            function()
                require("tuis").choose()
            end,
            desc = "TUIs: Choose",
        },
    },
}
