return {
    "OXY2DEV/helpview.nvim",
    lazy = true,
    ft = "help",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        preview = {
            icon_provider = "devicons"
        }
    }
}
