-- Actions Preview will display a floating window with a preview of code actions.

vim.pack.add({
    "http://github.com/aznhe21/actions-preview.nvim",
}, { confirm = false })

vim.keymap.set({ "n", "v" }, "<leader><enter>", function()
    require("actions-preview").code_actions()
end, { desc = "Actions Preview" })
