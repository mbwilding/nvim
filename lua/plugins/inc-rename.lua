-- Renamer with preview

vim.pack.add({
    "https://github.com/smjonas/inc-rename.nvim",
}, { confirm = false })

vim.keymap.set("n", "<leader>rn", function()
    return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "LSP: Rename" })

local opts = {
    -- input_buffer_type = "dressing",
}

require("inc_rename").setup(opts)
