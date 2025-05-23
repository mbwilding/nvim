return {
    "Wansmer/treesj",
    lazy = true,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            "<leader>j",
            "<CMD>TSJToggle<CR>",
            desc = "TreeSJ: Toggle",
        },
    },
    opts = {
        use_default_keymaps = false,
    },
}
