return {
    "sindrets/diffview.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons"
    },
    config = function()
        vim.keymap.set("n", "<leader>gdm", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: Open Merge/Rebase" })
        vim.keymap.set("n", "<leader>gdh", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diffview: Current File History" })
        vim.keymap.set("n", "<leader>gdH", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview: Repo File History" })
        vim.keymap.set("n", "<leader>gdf", "<cmd>DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle File Panel" })
        vim.keymap.set("n", "<leader>gdF", "<cmd>DiffviewFocusFiles<CR>", { desc = "Diffview: Focus File Panel" })
        vim.keymap.set("n", "<leader>gdr", "<cmd>DiffviewRefresh<CR>", { desc = "Diffview: Refresh" })
    end
}
