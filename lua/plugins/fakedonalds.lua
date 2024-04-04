return {
	"dundargoc/fakedonalds.nvim",
	config = function()
		vim.keymap.set("n", "<leader>tM", function()
			vim.cmd([[colorscheme fakedonalds]])
		end, { desc = "Theme: McDonalds" })
	end,
}
