-- Comment allows you to quickly comment out lines or blocks of code in many languages.

return {
    "numToStr/Comment.nvim",
    opts = {
        toggler = {
            line = "gc",
            block = "gb",
        },
    },
    config = function(_, opts)
        require("Comment").setup(opts)

        local ft = require("Comment.ft")
        ft.set("vhs", "# %s")
    end,
}
