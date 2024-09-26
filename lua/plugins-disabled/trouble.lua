return {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        {
            "<leader>td",
            "<CMD>Trouble diagnostics toggle<CR>",
            desc = "Trouble: Diagnostics",
        },
        {
            "<leader>tf",
            "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "Trouble: Buffer Diagnostics",
        },
        {
            "<leader>ts",
            "<CMD>Trouble symbols toggle focus=false<CR>",
            desc = "Trouble: Symbols",
        },
        {
            "<leader>tl",
            "<CMD>Trouble lsp toggle focus=false win.position=right<CR>",
            desc = "Trouble: LSP Definitions / References / ...",
        },
        {
            "<leader>tL",
            "<CMD>Trouble loclist toggle<CR>",
            desc = "Trouble: Location List",
        },
        {
            "<leader>tQ",
            "<CMD>Trouble qflist toggle<CR>",
            desc = "Trouble: Quickfix List",
        },
    },
}
