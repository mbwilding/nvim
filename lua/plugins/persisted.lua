return {
	"olimorris/persisted.nvim",
	lazy = false,
	config = function()
		require("persisted").setup({
			use_git_branch = false, -- create session files based on the branch of a git enabled repository
			autosave = true, -- automatically save session files when exiting Neovim
			should_autosave = function()
				return vim.bo.filetype ~= "alpha"
			end,    -- function to determine if a session should be autosaved
			autoload = true, -- automatically load the session for the cwd on Neovim startup
			silent = true, -- No message on loading a session
		})
		vim.keymap.set("n", "<leader>tp", "<CMD>Telescope persisted<CR>")
	end,
}
