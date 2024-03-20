return {
	"cbochs/grapple.nvim",
	opts = {
		scope = "git", -- also "git_branch"
	},
	event = { "BufReadPost", "BufNewFile" },
	cmd = "Grapple",
	keys = {
		-- { "<leader>z", "<cmd>Grapple toggle<cr>",         desc = "Grapple toggle tag" },
		-- { "<leader>Z", "<cmd>Grapple toggle_tags<cr>",    desc = "Grapple toggle tags" },
		-- { "<leader>K", "<cmd>Grapple toggle_scopes<cr>",  desc = "Grapple toggle scopes" },
		-- { "<leader>j", "<cmd>Grapple cycle forward<cr>",  desc = "Grapple cycle forward" },
		-- { "<leader>J", "<cmd>Grapple cycle backward<cr>", desc = "Grapple cycle backward" },
		-- { "<leader>h", "<cmd>Grapple select index=1<cr>", desc = "Grapple select 1" },
		-- { "<leader>t", "<cmd>Grapple select index=2<cr>", desc = "Grapple select 2" },
		-- { "<leader>n", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 3" },
		-- { "<leader>s", "<cmd>Grapple select index=3<cr>", desc = "Grapple select 4" },
	},
}
