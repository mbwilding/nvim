return {
	"aznhe21/actions-preview.nvim",
	config = function()
		require("actions-preview").setup()
		vim.keymap.set(
			{ "v", "n" },
			"<leader><enter>",
			require("actions-preview").code_actions,
			{ silent = true, desc = "Action Preview" }
		)
	end,
}
