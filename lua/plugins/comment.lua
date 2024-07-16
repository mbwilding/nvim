return {
    -- Comment visual regions/lines
    "numToStr/Comment.nvim",
    config = function()
        vim.keymap.del('n', 'gc')

        require('Comment').setup({
            toggler = {
                line = "gc",
                block = "gb",
            }
        })
    end
}
