return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"nvim-neotest/nvim-nio",
		-- Test suites
		"Issafalcon/neotest-dotnet",
		"rouge8/neotest-rust",
		"markemmons/neotest-deno",
		"nvim-neotest/neotest-jest"
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-rust"),
				require("neotest-deno"),
				require('neotest-jest')({
					jestCommand = "npm test --",
					jestConfigFile = "jest.config.js",
					env = { CI = true },
					cwd = function(_path)
						return vim.fn.getcwd()
					end,
				}),
				require("neotest-dotnet")({
					dap = {
						-- Extra arguments for nvim-dap configuration
						-- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
						args = { justMyCode = false },
						-- Enter the name of your dap adapter, the default value is netcoredbg
						adapter_name = "netcoredbg",
					},
					-- Let the test-discovery know about your custom attributes (otherwise tests will not be picked up)
					-- Note: Only custom attributes for non-parameterized tests should be added here. See the support note about parameterized tests
					custom_attributes = {
						xunit = { "MyCustomFactAttribute" },
						nunit = { "MyCustomTestAttribute" },
						mstest = { "MyCustomTestMethodAttribute" },
					},
					-- Provide any additional "dotnet test" CLI commands here. These will be applied to ALL test runs performed via neotest. These need to be a table of strings, ideally with one key-value pair per item.
					dotnet_additional_args = {
						"--verbosity detailed",
					},
					-- Tell neotest-dotnet to use either solution (requires .sln file) or project (requires .csproj or .fsproj file) as project root
					-- Note: If neovim is opened from the solution root, using the 'project' setting may sometimes find all nested projects, however,
					--       to locate all test projects in the solution more reliably (if a .sln file is present) then 'solution' is better.
					discovery_root = "project", -- Default
				}),
			},
		})

		vim.keymap.set("n", "<leader>ntr", function()
			require("neotest").run.run()
		end, { desc = "Neotest: Run nearest test" })

		vim.keymap.set("n", "<leader>ntf", function()
			require("neotest").run.run(vim.fn.expand("%"))
		end, { desc = "Neotest: Run current file" })

		vim.keymap.set("n", "<leader>ntd", function()
			require("neotest").run.run({ strategy = "dap" })
		end, { desc = "Neotest: Debug nearest test" })

		vim.keymap.set("n", "<leader>nts", function()
			require("neotest").run.stop()
		end, { desc = "Neotest: Stop nearest test" })

		vim.keymap.set("n", "<leader>nta", function()
			require("neotest").run.attach()
		end, { desc = "Neotest: Attach nearest test" })

		vim.keymap.set("n", "<leader>ntw", function()
			require("neotest").watch.watch()
		end, { desc = "Neotest: Watch" })

		vim.keymap.set("n", "<leader>ntt", function()
			require("neotest").watch.toggle()
		end, { desc = "Neotest: Watch Toggle" })

		vim.keymap.set("n", "<leader>ntW", function()
			require("neotest").watch.toggle(vim.fn.expand("%"))
		end, { desc = "Neotest: Watch File" })
	end,
}
