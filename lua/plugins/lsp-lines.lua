return {
    "griwes/lsp_lines.nvim",
    branch = "griwes-patched",
    config = function()
        require("lsp_lines").setup()

        vim.diagnostic.config({
            virtual_text = false, -- Disables in-built
            virtual_lines = {
                only_current_line = false,
                highlight_whole_line = false
            }
        })

        vim.keymap.set(
            "n",
            "<leader>hl",
            require("lsp_lines").toggle,
            { desc = "LSP Lines: Toggle" }
        )
    end,
}
