-- Comment allows you to quickly comment out lines or blocks of code in many languages.

vim.pack.add({
    "https://github.com/numToStr/Comment.nvim",
}, { confirm = false })

local opts = {
    toggler = {
        line = "gc",
        block = "gb",
    },
}

require("Comment").setup(opts)

local ft = require("Comment.ft")
ft.set("vhs", "# %s")
