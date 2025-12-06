return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    config = function(_, opts)
        require("tiny-inline-diagnostic").setup(opts)
        vim.diagnostic.config({ virtual_text = false })
    end,
    opts = {
        options = {
            multilines = {
                enabled = true,
            },
            add_messages = {
                display_count = true,
            },
            show_source = {
                enabled = true,
            },
        },
    },
}
