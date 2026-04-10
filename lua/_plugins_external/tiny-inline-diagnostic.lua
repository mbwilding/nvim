return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    keys = {
        {
            "<leader>it",
            function()
                require("tiny-inline-diagnostic").toggle()
            end,
            desc = "Tiny Diag: Toggle",
        },
    },
    opts = {
        preset = "powerline", -- classic, minimal, powerline, ghost, simple, nonerdfont, amongus
        throttle = 0, -- 20
        softwrap = 30, -- min number of chars before wrap
        options = {
            multilines = {
                enabled = true,
                trim_whitespaces = true,
            },
            add_messages = {
                display_count = true,
            },
            show_source = {
                enabled = true,
            },
        },
    },
    config = function(_, opts)
        require("tiny-inline-diagnostic").setup(opts)
        vim.diagnostic.config({ virtual_text = false })
    end,
}
