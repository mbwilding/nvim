return {
	"mbwilding/gronk.nvim",
	config = function()
		vim.cmd([[colorscheme gronk]])

		vim.keymap.set("n", "<leader>tG", function()
			vim.cmd([[colorscheme gronk]])
		end, { desc = "Theme: Gronk" })
	end,
}
