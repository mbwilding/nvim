return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    ---@type render.md.UserConfig
    opts = {
        file_types = { "markdown", "Avante" },
    },
    ft = { "markdown", "Avante" },
}
