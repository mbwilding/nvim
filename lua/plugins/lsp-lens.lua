return {
    "VidocqH/lsp-lens.nvim",
    lazy = true,
    event = "LspAttach",
    keys = {
        {
            "<leader>ui",
            "<CMD>LspLensToggle<CR>",
            desc = "Launcher: File",
        },
    },
    opts = {
        enable = true,
        include_declaration = false,
        sections = {
            definition = function(count)
                if count > 1 then
                    return count .. " definitions"
                end
            end,
            references = function(count)
                if count > 1 then
                    return count .. " usages"
                end
            end,
            implements = function(count)
                if count > 1 then
                    return count .. " implementations"
                end
            end,
            git_authors = false,
            -- git_authors = function(latest_author, count)
            --     if latest_author == "Not Committed Yet" then
            --         latest_author = "uncommitted"
            --     end
            --     return "  " .. latest_author .. (count - 1 == 0 and "" or (" + " .. count - 1))
            -- end,
        },
        ignore_filetype = {
            "prisma",
        },
        target_symbol_kinds = {
            vim.lsp.protocol.SymbolKind.Function,
            vim.lsp.protocol.SymbolKind.Method,
            vim.lsp.protocol.SymbolKind.Interface,
        },
        wrapper_symbol_kinds = { vim.lsp.protocol.SymbolKind.Class, vim.lsp.protocol.SymbolKind.Struct },
    },
}
