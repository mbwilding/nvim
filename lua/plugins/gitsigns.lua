return {
	"lewis6991/gitsigns.nvim",
	opts = {
		-- See `:help gitsigns.txt`
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map({ "n", "v" }, "]c", function()
				if vim.wo.diff then
					return "]c"
				end
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Git Signs: Jump to next hunk" })

			map({ "n", "v" }, "[c", function()
				if vim.wo.diff then
					return "[c"
				end
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, { expr = true, desc = "Git Signs: Jump to previous hunk" })

			-- Actions
			-- visual mode
			map("v", "<leader>gss", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git Signs: Stage Git Hunk" })
			map("v", "<leader>gsr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, { desc = "Git Signs: Reset Git Hunk" })
			-- normal mode
			map("n", "<leader>gsh", gs.stage_hunk, { desc = "Git Signs: Git Stage Hunk" })
			map("n", "<leader>gsr", gs.reset_hunk, { desc = "Git Signs: Git Reset Hunk" })
			map("n", "<leader>gsS", gs.stage_buffer, { desc = "Git Signs: Git Stage Buffer" })
			map("n", "<leader>gsu", gs.undo_stage_hunk, { desc = "Git Signs: Undo Stage Hunk" })
			map("n", "<leader>gsR", gs.reset_buffer, { desc = "Git Signs: Git Reset buffer" })
			map("n", "<leader>gsp", gs.preview_hunk, { desc = "Git Signs: Preview Git Hunk" })
			map("n", "<leader>gsl", function()
				gs.blame_line({ full = false })
			end, { desc = "Git Signs: Git Blame Line" })
			map("n", "<leader>gsd", gs.diffthis, { desc = "Git Signs: Git Diff Against Index" })
			map("n", "<leader>gsD", function()
				gs.diffthis("~")
			end, { desc = "Git Signs: Git Diff Against Last Commit" })

			-- Toggles
			map("n", "<leader>gsb", gs.toggle_current_line_blame, { desc = "Git Signs: Toggle Git Blame Line" })
			map("n", "<leader>gst", gs.toggle_deleted, { desc = "Git Signs: Toggle Git Show Deleted" })

			-- Text object
			map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Git Signs: Select Git Hunk" })

			-- TODO: Fix this
			require("which-key").register({
				gs = { name = "Git Signs" },
			}, { prefix = "<leader>" })
		end,
	},
}
