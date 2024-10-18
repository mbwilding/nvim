return {
    "smjonas/inc-rename.nvim",
    lazy = true,
    event = "LspAttach",
    config = function()
        require("inc_rename").setup({
            -- input_buffer_type = "dressing",
        })

        vim.keymap.set("n", "<leader>rn", function()
            return ":IncRename " .. vim.fn.expand("<cword>")
        end, { expr = true, desc = "LSP: Rename" })
    end,
}
