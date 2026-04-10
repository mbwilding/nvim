return {
    "MeanderingProgrammer/render-markdown.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    ---@type render.md.UserConfig
    opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "Avante", "CodeCompanion", "opencode_output" },
    },
}
