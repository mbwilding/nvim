return {
    "Wansmer/treesj",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    keys = {
        {
            "<leader>sj",
            "<CMD>TSJToggle<CR>",
            desc = "TreeSJ: Toggle",
        },
    },
    opts = {},
}
