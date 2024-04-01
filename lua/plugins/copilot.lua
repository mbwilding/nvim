return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	build = ":Copilot auth",
	module = "copilot",
	opts = {
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
	},
	-- dependencies = {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	config = function()
	-- 		require("copilot_cmp").setup()
	-- 	end,
	-- },
}
