return {
	"nvim-telescope/telescope.nvim",
	-- branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope-ui-select.nvim",
		"aaronhallaert/advanced-git-search.nvim",
		"debugloop/telescope-undo.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			-- Build command adjusted to use 'make' if available, otherwise 'cmake'
			build = function()
				if vim.fn.executable("make") == 1 then
					return "make"
				elseif vim.fn.executable("cmake") == 1 then
					return
					"cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
				else
					error("Neither 'make' nor 'cmake' are available for building telescope-fzf-native.nvim")
				end
			end,
			-- This plugin is conditionally loaded if either 'make' or 'cmake' is available
			cond = function()
				return vim.fn.executable("make") == 1 or vim.fn.executable("cmake") == 1
			end,
		},
		"nvim-tree/nvim-web-devicons",
		"cbochs/grapple.nvim",
	},
	config = function()
		-- Telescope is a fuzzy finder that comes with a lot of different things that
		-- it can fuzzy find! It's more than just a "file finder", it can search
		-- many different aspects of Neovim, your workspace, LSP, and more!
		--
		-- The easiest way to use telescope, is to start by doing something like:
		--  :Telescope help_tags
		--
		-- After running this command, a window will open up and you're able to
		-- type in the prompt window. You'll see a list of help_tags options and
		-- a corresponding preview of the help.
		--
		-- Two important keymaps to use while in telescope are:
		--  - Insert mode: <c-/>
		--  - Normal mode: ?
		--
		-- This opens a window that shows you all of the keymaps for the current
		-- telescope picker. This is really useful to discover what Telescope can
		-- do as well as how to actually do it!

		-- [[ Configure Telescope ]]
		-- See `:help telescope` and `:help telescope.setup()`
		require("telescope").setup({
			-- You can put your default mappings / updates / etc. in here
			--  All the info you're looking for is in `:help telescope.setup()`
			--
			-- defaults = {
			--   mappings = {
			--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
			--   },
			-- },
			pickers = {
				find_files = {
					hidden = true,
				},
			},
			defaults = {
				vimgrep_arguments = {
					"rg",
					"--hidden",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
				},
				file_ignore_patterns = {
					".DS_Store",
					".git/",
					".git\\",
					"node_modules/",
					"node_modules\\",
					"vendor/",
					"vendor\\",
					"build/",
					"build\\",
					"dist/",
					"dist\\",
					"target/",
					"target\\",
					".cache/",
					".cache\\",
					".vscode/",
					".vscode\\",
					".vs/",
					".vs\\",
					".idea/",
					".idea\\",
					".next/",
					".next\\",
				},
			},
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
				["advanced_git_search"] = {
					-- fugitive or diffview
					diff_plugin = "diffview",
					-- customize git in previewer
					-- e.g. flags such as { "--no-pager" }, or { "-c", "delta.side-by-side=false" }
					git_flags = {},
					-- customize git diff in previewer
					-- e.g. flags such as { "--raw" }
					git_diff_flags = {},
					-- Show builtin git pickers when executing "show_custom_functions" or :AdvancedGitSearch
					show_builtin_git_pickers = false,
					entry_default_author_or_date = "author", -- one of "author" or "date"

					-- Telescope layout setup
					telescope_theme = {
						function_name_1 = {
							-- Theme options
						},
						function_name_2 = "dropdown",
						-- e.g. realistic example
						show_custom_functions = {
							layout_config = { width = 0.4, height = 0.4 },
						},
					},
				},
			},
		})

		-- Enable telescope extensions, if they are installed
		local extensions = {
			"fzf",
			"ui-select",
			"advanced_git_search",
			"grapple",
			"noice",
			"undo",
			"package_info"
		}
		for _, ext in ipairs(extensions) do
			pcall(require("telescope").load_extension, ext)
		end

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope: Search help" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Telescope: Search keymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Telescope: Search files" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Telescope: Search Select" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Telescope: Search current word" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Telescope: Search by grep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Telescope: Search diagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Telescope: Search resume" })
		vim.keymap.set(
			"n",
			"<leader>s.",
			builtin.oldfiles,
			{ desc = 'Telescope: Search Recent Files ("." for repeat)' }
		)
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "Telescope: Find existing buffers" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Telescope: Fuzzily search in current buffer" })

		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Telescope: Live grep in open files",
			})
		end, { desc = "Telescope: Search in open files" })

		-- Search Neovim config files
		vim.keymap.set("n", "<leader>sN", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Telescope: Search Neovim files" })

		-- Search Neovim config content
		vim.keymap.set("n", "<leader>sn", function()
			builtin.live_grep({ cwd = vim.fn.stdpath("config") })
		end, { desc = "Telescope: Search Neovim files" })

		-- Search work ci files
		vim.keymap.set("n", "<leader>sC", function()
			builtin.find_files({ cwd = "F:\\rwwa\\common\\gitlab-ci-shared" })
		end, { desc = "Telescope: Search work CI files" })

		-- Search work ci content
		vim.keymap.set("n", "<leader>sc", function()
			builtin.live_grep({ cwd = "F:\\rwwa\\common\\gitlab-ci-shared" })
		end, { desc = "Telescope: Search work CI content" })

		-- Search work pe files
		vim.keymap.set("n", "<leader>sE", function()
			builtin.find_files({ cwd = "F:\\rwwa\\platform-enablement" })
		end, { desc = "Telescope: Search work PE files" })

		-- Search work pe content
		vim.keymap.set("n", "<leader>se", function()
			builtin.live_grep({ cwd = "F:\\rwwa\\platform-enablement" })
		end, { desc = "Telescope: Search work PE content" })

		-- Search work files
		vim.keymap.set("n", "<leader>sW", function()
			builtin.find_files({ cwd = "F:\\rwwa" })
		end, { desc = "Telescope: Search work files" })

		-- Search work content
		vim.keymap.set("n", "<leader>sw", function()
			builtin.live_grep({ cwd = "F:\\work" })
		end, { desc = "Telescope: Search work content" })

		-- Search language files
		vim.keymap.set("n", "<leader>sL", function()
			builtin.find_files({ cwd = "F:\\Languages" })
		end, { desc = "Telescope: Search work files" })

		-- Search language content
		vim.keymap.set("n", "<leader>sl", function()
			builtin.live_grep({ cwd = "F:\\Languages" })
		end, { desc = "Telescope: Search work content" })

		-- Advanced Git Search
		vim.keymap.set(
			"n",
			"<leader>sG",
			"<cmd>AdvancedGitSearch<CR>",
			{ silent = true, desc = "Telescope: Advanced git search" }
		)

		-- Undo
		vim.keymap.set(
			"n",
			"<leader>u",
			"<cmd>Telescope undo<CR>",
			{ silent = true, desc = "Telescope: Undo history" }
		)
	end,
}
