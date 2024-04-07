return {
	"akinsho/nvim-toggleterm.lua",
	config = function()
		local toggle_term = require("toggleterm")

		local shell_command
		if vim.fn.has("win32") == 1 then
			shell_command = "pwsh.exe -NoLogo -NoProfile"
		else
			shell_command = nil
		end

		toggle_term.setup({
			-- open_mapping = [[<c-\>]],
			start_in_insert = true,
			terminal_mappings = true,
			-- direction = "float",
			shell = shell_command,
			auto_scroll = true,
			persist_mode = false,
			persist_size = true,
			close_on_exit = true,
			hide_numbers = true,
			shade_terminals = true,
		})

		vim.keymap.set({ "n", "t" }, "<leader>th", "<cmd>:1ToggleTerm direction=horizontal size=5<CR>")
		vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>:2ToggleTerm direction=horizontal size=5<CR>")
		vim.keymap.set({ "n", "t" }, "<leader>tn", "<cmd>:3ToggleTerm direction=horizontal size=5<CR>")
		vim.keymap.set({ "n", "t" }, "<leader>ts", "<cmd>:4ToggleTerm direction=horizontal size=5<CR>")
		vim.keymap.set({ "n", "t" }, "<leader>tf", "<cmd>:4ToggleTerm direction=float<CR>")
		vim.keymap.set({ "n", "t" }, "<leader>tc", "<cmd>:ToggleTermToggleAll<CR>")
	end,
}
