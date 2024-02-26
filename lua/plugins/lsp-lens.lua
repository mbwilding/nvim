return {
  "VidocqH/lsp-lens.nvim",
  config = function()
    local SymbolKind = vim.lsp.protocol.SymbolKind

    local function formatCount(count, label, showIfOne)
      if count == nil or (count == 1 and not showIfOne) then
        return nil
      elseif count == 1 then
        return count .. " " .. label:sub(1, -2) -- Removes the last character for singular form
      else
        return count .. " " .. label
      end
    end

    require("lsp-lens").setup({
      enable = true,
      include_declaration = false,
      sections = {
        definition = function(count)
          return formatCount(count, "definitions", false)
        end,
        references = function(count)
          return formatCount(count, "usages", true)
        end,
        implements = function(count)
          return formatCount(count, "implementations", true)
        end,
        git_authors = function(latest_author, count)
          return " " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
        end,
      },
      ignore_filetype = {
        "prisma",
      },
      target_symbol_kinds = { SymbolKind.Function, SymbolKind.Method, SymbolKind.Interface },
      wrapper_symbol_kinds = { SymbolKind.Class, SymbolKind.Struct },
    })

    vim.keymap.set("n", "<leader>iu", "<cmd>LspLensToggle<CR>", { desc = "LSP Lens: Toggle" })
  end
}
