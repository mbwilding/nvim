return {
    "Wansmer/treesj",
    lazy = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            "<leader>sj",
            "<CMD>TSJToggle<CR>",
            desc = "TreeSJ: Toggle",
        },
    },
    opts = {},
}
