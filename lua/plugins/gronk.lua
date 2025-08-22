-- Custom theme based on the Rider Dark theme

vim.pack.add({
    "https://github.com/mbwilding/gronk.nvim",
}, { confirm = false })

require("gronk").setup({
    transparent = false,
})

vim.cmd([[colorscheme gronk-wilding]])
