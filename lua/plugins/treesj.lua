vim.pack.add({
    "https://github.com/Wansmer/treesj",
}, { confirm = false })

vim.keymap.set("n", "<leader>j", "<CMD>TSJToggle<CR>", { desc = "TreeSJ: Toggle" })

local opts = {
    use_default_keymaps = false,
}

require("treesj").setup(opts)
