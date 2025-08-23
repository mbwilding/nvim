-- Shows key maps

vim.pack.add({
    "https://github.com/folke/which-key.nvim",
}, { confirm = false })

vim.keymap.set("n", "<leader>?", function()
    require("which-key").show({ global = false })
end, { desc = "Which-Key: Buffer Local Keymaps" })

local opts = {
    delay = 1000,
}

require("which-key").setup(opts)
