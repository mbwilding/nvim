return {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
    },
    config = function()
        vim.o.foldenable = true
        -- vim.o.foldcolumn = "auto:9"
        -- vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep:│,foldclose:"
        vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
        vim.o.foldcolumn = "1"
        vim.o.foldlevel = 99999999
        vim.o.foldlevelstart = 99999999

        vim.keymap.set("n", "zR", require("ufo").openAllFolds, { desc = "UFO Folds: Open All" })
        vim.keymap.set("n", "zM", require("ufo").closeAllFolds, { desc = "UFO Folds: Close All" })

        require("ufo").setup()
    end,
}
