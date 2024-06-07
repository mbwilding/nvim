return {
	"tpope/vim-projectionist",
	dependencies = {
		"tpope/vim-dispatch",
	},
	config = function()
		vim.g.projectionist_heuristics = {
			-- TypeScript
			["tsconfig.json"] = {
				["*.test.ts"] = {
					type = "test",
					alternate = {
						"{}.ts",
						"{}.tsx",
					},
				},
				["*.test.tsx"] = {
					type = "test",
					alternate = {
						"{}.ts",
						"{}.tsx",
					},
				},
				["*.ts"] = {
					type = "source",
					alternate = {
						"{}.test.ts",
						"{}.test.tsx",
						"{}.stories.tsx",
					},
				},
				["*.tsx"] = {
					type = "source",
					alternate = {
						"{}.test.ts",
						"{}.test.tsx",
						"{}.stories.tsx",
					},
				},
				["*.stories.tsx"] = {
					type = "source",
					alternate = {
						"{}.tsx",
					},
				},
			},
		}

		vim.keymap.set("n", "<leader>af", "<CMD>A<CR>", { desc = "Projectionist: Alternate File" })
		vim.keymap.set("n", "<leader>as", "<CMD>AS<CR>", { desc = "Projectionist: Alternate File Horizontal Split" })
		vim.keymap.set("n", "<leader>av", "<CMD>AV<CR>", { desc = "Projectionist: Alternate File Vertical Split" })
	end,
}
