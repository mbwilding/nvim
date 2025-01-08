return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    keys = {
        {
            "<leader>zA",
            function()
                require("ufo").openAllFolds()
            end,
            desc = "UFO Folds: Expand All",
        },
        {
            "<leader>zM",
            function()
                require("ufo").closeAllFolds()
            end,
            desc = "UFO Folds: Collapse All",
        },
    },
    opts = {},
    config = function(_, opts)
        vim.o.foldenable = true
        vim.o.foldcolumn = "1"
        vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
        vim.o.foldlevel = 99999999
        vim.o.foldlevelstart = 99999999

        require("ufo").setup(opts)
    end
}
