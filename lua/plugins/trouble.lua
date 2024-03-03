return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("trouble").setup({

        })

        vim.keymap.set("n", "<leader>lq", ":TroubleToggle document_diagnostics<CR>",
            { desc = "Toggle Document Diagnostics" })
        vim.keymap.set("n", "<leader>ld", ":TroubleToggle document_diagnostics<CR>",
            { desc = "Toggle Document Diagnostics" })
        vim.keymap.set("n", "<leader>la", ":TroubleToggle quickfix<CR>")
        vim.keymap.set("n", "<leader>ll", ":TroubleToggle loclist<CR>", { desc = "Toggle Local List" })
        vim.keymap.set("n", "<leader>lw", ":TroubleToggle workspace_diagnostics<CR>",
            { desc = "Toggle Workspace Diagnostics" })
        vim.keymap.set("n", "<leader>lr", ":TroubleToggle lsp_references<CR>", { desc = "Toggle LSP References" })
    end
}
