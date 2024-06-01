return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod",                     lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	init = function()
		vim.g.db_ui_use_nerd_fonts = 1
		vim.keymap.set("n", "<leader>dbb", "<cmd>DBUI<CR>", { desc = "Dadbod: UI" })
		vim.keymap.set("n", "<leader>dbt", "<cmd>DBUIToggle<CR>", { desc = "Dadbod: Toggle" })

		require("cmp").setup.filetype({ "sql" }, {
			sources = {
				{ name = "vim-dadbod-completion" },
				{ name = "buffer" },
			}
		})

		vim.g.dbs = {
			{ name = 'dev', url = 'postgres://postgres:Developer01@localhost:5432/_Namespace._CapabilityName' },
		}
	end,
}
