-- Custom theme based on the Rider Dark theme

return {
    "mbwilding/gronk.nvim",
    lazy = false,
    dev = true,
    priority = 1001,
    config = function()
        vim.cmd([[colorscheme gronk]])
    end,
}
