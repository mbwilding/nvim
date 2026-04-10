-- Comment allows you to quickly comment out lines or blocks of code in many languages, deprecated in favour of inbuilt neovim 0.10 comments.

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
    end,
}
