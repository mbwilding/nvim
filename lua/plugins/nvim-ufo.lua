return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    keys = {
        {
            "<leader>zA",
            function()
                require("ufo").openAllFolds()
            end,
            desc = "UFO Folds: Expand All",
        },
        {
            "<leader>zM",
            function()
                require("ufo").closeAllFolds()
            end,
            desc = "UFO Folds: Collapse All",
        },
    },
    opts = {},
}
