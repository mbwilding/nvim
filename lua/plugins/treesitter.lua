return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        {
            "nvim-treesitter/nvim-treesitter-textobjects",
            branch = "main",
        },
    },
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
}
