-- Custom theme based on the Rider Dark theme

return {
    "mbwilding/gronk.nvim",
    lazy = false,
    dev = false,
    priority = 1001,
    config = function()
        require("gronk").setup({
            transparent = true,
        })

        vim.cmd([[colorscheme gronk-wilding]])
    end,
}
