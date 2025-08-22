-- Advanced fold support

vim.pack.add({
    "https://github.com/kevinhwang91/nvim-ufo",
    "https://github.com/kevinhwang91/promise-async",
}, { confirm = false })

vim.keymap.set("n", "<leader>zA", function()
    require("ufo").openAllFolds()
end, { desc = "UFO Folds: Expand All" })

vim.keymap.set("n", "<leader>zM", function()
    require("ufo").closeAllFolds()
end, { desc = "UFO Folds: Expand All" })

vim.o.foldenable = true
-- vim.o.foldcolumn = "1"
vim.o.foldcolumn = "0"
vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
vim.o.foldlevel = 99999999
vim.o.foldlevelstart = 99999999

require("ufo").setup()
