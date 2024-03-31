return {
	"sindrets/diffview.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		vim.keymap.set("n", "<leader>dvm", "<cmd>DiffviewOpen<CR>", { desc = "Diffview: Open Merge/Rebase" })
		vim.keymap.set(
			"n",
			"<leader>dvh",
			"<cmd>DiffviewFileHistory %<CR>",
			{ desc = "Diffview: Current File History" }
		)
		vim.keymap.set("n", "<leader>dvH", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview: Repo File History" })
		vim.keymap.set("n", "<leader>dvf", "<cmd>DiffviewToggleFiles<CR>", { desc = "Diffview: Toggle File Panel" })
		vim.keymap.set("n", "<leader>dvF", "<cmd>DiffviewFocusFiles<CR>", { desc = "Diffview: Focus File Panel" })
		vim.keymap.set("n", "<leader>dvr", "<cmd>DiffviewRefresh<CR>", { desc = "Diffview: Refresh" })
	end,
}
