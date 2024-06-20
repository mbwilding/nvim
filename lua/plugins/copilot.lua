return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	module = "copilot",
	config = function()
		require("copilot").setup({
			suggestion = {
				enabled = true,
				auto_trigger = true,
				debounce = 75,
				keymap = {
					accept = "<C-y>",
					accept_word = false,
					accept_line = false,
					next = "<C-n>",
					prev = "<C-p>",
					dismiss = "<C-Esc>",
				},
			},
			panel = { enabled = true },
			filetypes = {
				yaml = false,
				markdown = false,
				help = false,
				gitcommit = false,
				gitrebase = false,
				hgcommit = false,
				svn = false,
				cvs = false,
				["."] = false,
			},
		})

		vim.keymap.set("n", "<leader>cpe", "<CMD>Copilot enable<CR>", { desc = "Copilot: Enable" })
		vim.keymap.set("n", "<leader>cpd", "<CMD>Copilot disable<CR>", { desc = "Copilot: Disable" })
		vim.keymap.set("n", "<leader>cpt", "<CMD>Copilot toggle<CR>", { desc = "Copilot: Toggle" })
	end,
	-- dependencies = {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}
