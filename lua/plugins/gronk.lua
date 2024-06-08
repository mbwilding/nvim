return {
	"mbwilding/gronk.nvim",
	priority = 1000,
	config = function()
		require("gronk").setup({
			transparent = true,
		})

		vim.cmd([[colorscheme gronk]])
	end,
}
