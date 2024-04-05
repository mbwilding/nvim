return {
	"mbwilding/gronk.nvim",
	--"dundargoc/fakedonalds.nvim",
	config = function()
		require("gronk").setup({
			transparent = true,
		})

		vim.cmd([[colorscheme gronk]])
		--vim.cmd([[colorscheme fakedonalds]])
	end,
}
