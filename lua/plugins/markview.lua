-- Markview shows a formatted version of markdown unless in insert mode.

return {
    "OXY2DEV/markview.nvim",
    lazy = true,
    event = "BufEnter",
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        preview = {
            icon_provider = "devicons",
        },
    },
}
