return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				-- python = { "isort", "black" },

				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "prettierd", "prettier" } },
			},
		})

		-- Format on save [async]
		--vim.api.nvim_create_autocmd("BufWritePre", {
		--	pattern = "*",
		--	callback = function(args)
		--		vim.defer_fn(function()
		--			require("conform").format({ bufnr = args.buf })
		--		end, 0) -- Defer the execution, making it asynchronous
		--	end,
		--})

		-- Format on save
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*",
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
