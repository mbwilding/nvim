return {
	"mbwilding/profiles.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"akinsho/nvim-toggleterm.lua",
	},
	config = function()
		local profiles = require("profiles")

		vim.keymap.set("n", "<leader>o", function()
			profiles.select_profile()
		end, { desc = "Profiles: Select Local" })

		vim.keymap.set("n", "<leader>O", function()
			profiles.select_default_profile()
		end, { desc = "Profiles: Select Default" })
	end,
}
