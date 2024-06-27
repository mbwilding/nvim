return {
	"vxpm/ferris.nvim",
	config = function()
		require("ferris").setup()

		vim.keymap.set(
			"n",
			"<leader>Re",
			require("ferris.methods.expand_macro"),
			{ silent = true, desc = "Ferris: Expand macro" }
		)
		vim.keymap.set(
			"n",
			"<leader>Rj",
			require("ferris.methods.join_lines"),
			{ silent = true, desc = "Ferris: Join lines" }
		)
		vim.keymap.set("n", "<leader>RH", require("ferris.methods.view_hir"), { silent = true, desc = "Ferris: HIR" })
		vim.keymap.set("n", "<leader>RM", require("ferris.methods.view_mir"), { silent = true, desc = "Ferris: MIR" })
		vim.keymap.set(
			"n",
			"<leader>Rl",
			require("ferris.methods.view_memory_layout"),
			{ silent = true, desc = "Ferris: Memory layout" }
		)
		vim.keymap.set(
			"n",
			"<leader>Ri",
			require("ferris.methods.view_item_tree"),
			{ silent = true, desc = "Ferris: Item tree" }
		)
		vim.keymap.set(
			"n",
			"<leader>Rs",
			require("ferris.methods.view_syntax_tree"),
			{ silent = true, desc = "Ferris: Syntax tree" }
		)
		vim.keymap.set(
			"n",
			"<leader>Rc",
			require("ferris.methods.open_cargo_toml"),
			{ silent = true, desc = "Ferris: Open Cargo.toml" }
		)
		vim.keymap.set(
			"n",
			"<leader>Rq",
			require("ferris.methods.open_parent_module"),
			{ silent = true, desc = "Ferris: Open parent module" }
		)
		vim.keymap.set(
			"n",
			"<leader>Rof",
			require("ferris.methods.open_documentation"),
			{ silent = true, desc = "Ferris: Open documentation" }
		)
		vim.keymap.set(
			"n",
			"<leader>Rw",
			require("ferris.methods.reload_workspace"),
			{ silent = true, desc = "Ferris: Reload workspace" }
		)
		vim.keymap.set(
			"n",
			"<leader>Rm",
			require("ferris.methods.rebuild_macros"),
			{ silent = true, desc = "Ferris: Rebuild macros" }
		)
	end,
}
