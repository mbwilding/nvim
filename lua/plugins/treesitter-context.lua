local toggled = false

return {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            "<leader>ix",
            function()
                require("treesitter-context").toggle()
                toggled = not toggled
                vim.notify("Treesitter Context: " .. tostring(toggled))
            end,
            desc = "Treesitter: Context Rows",
        },
    },
    opts = {
        enable = false,
        mode = "topline", -- Also: cursor
    },
}
