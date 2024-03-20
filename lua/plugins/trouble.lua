return {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("trouble").setup({

        })

        vim.keymap.set("n", "<leader>td", ":TroubleToggle document_diagnostics<CR>",
            { desc = "Trouble: Toggle Document Diagnostics" })
        vim.keymap.set("n", "<leader>tq", ":TroubleToggle quickfix<CR>", { desc = "Trouble: Quick Fix" })
        vim.keymap.set("n", "<leader>tl", ":TroubleToggle loclist<CR>", { desc = "Trouble: Toggle Local List" })
        vim.keymap.set("n", "<leader>tw", ":TroubleToggle workspace_diagnostics<CR>",
            { desc = "Trouble: Toggle Workspace Diagnostics" })
        vim.keymap.set("n", "<leader>tr", ":TroubleToggle lsp_references<CR>",
            { desc = "Trouble: Toggle LSP References" })
    end
}
