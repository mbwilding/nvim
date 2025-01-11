return {
    "kylechui/nvim-surround",
    lazy = true,
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup()
    end,
}
