return {
	"VidocqH/lsp-lens.nvim",
	config = function()
		local SymbolKind = vim.lsp.protocol.SymbolKind

		require("lsp-lens").setup({
			enable = true,
			include_declaration = false,
			sections = {
				definition = function(count)
					if count > 1 then
						return count .. " " .. "definitions"
					end
				end,
				references = function(count)
					if count == 1 then
						return count .. " usage"
					elseif count > 1 then
						return count .. " usages"
					end
				end,
				implements = function(count)
					if count == 1 then
						return count .. " implementation"
					else
						return count .. " implementations"
					end
				end,
                git_authors = nil,
				-- git_authors = function(latest_author, count)
				-- 	if latest_author == "Not Committed Yet" then
				-- 		latest_author = "uncommitted"
				-- 	end
				-- 	return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
				-- end,
			},
			ignore_filetype = {
				"prisma",
			},
			target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
			wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
		})

		vim.keymap.set("n", "<leader>iu", "<cmd>LspLensToggle<CR>", { desc = "LSP Lens: Toggle" })
	end,
}
