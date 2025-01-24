-- Custom theme based on the Rider Dark theme

return {
    "mbwilding/gronk.nvim",
    lazy = false,
    dev = true,
    priority = 1000,
    config = function()
        require("gronk").setup({
            transparent = true,
        })

        vim.cmd([[colorscheme gronk-wilding]])
    end,
}
