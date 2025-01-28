-- Custom theme based on the Rider Dark theme

return {
    "mbwilding/gronk.nvim",
    lazy = false,
    dev = true,
    priority = 1000,
    config = function()
        require("gronk").setup({
            transparent = false,
        })

        vim.cmd([[colorscheme gronk-wilding]])
        -- vim.cmd([[colorscheme gronk-mono]])
    end,
}
