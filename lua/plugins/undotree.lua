-- Shows a history of undos

vim.pack.add({
    "https://github.com/mbbill/undotree",
}, { confirm = false })

vim.keymap.set("n", "<leader>u", "<CMD>UndotreeToggle<CR>", { desc = "UndoTree: Toggle" })
