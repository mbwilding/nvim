-- Copilot integration.

return {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    event = "InsertEnter",
    keys = {
        {
            "<leader>iC",
            "<CMD>Copilot toggle<CR>",
            desc = "Copilot: Toggle",
        },
    },
    opts = {
        panel = {
            enable = false,
        },
        suggestion = {
            enabled = false,
            auto_trigger = true,
            hide_during_completion = true,
            debounce = 75,
            keymap = {
                accept = "<C-y>",
                accept_word = false,
                accept_line = false,
                next = "<C-n>",
                prev = "<C-p>",
                dismiss = "<C-Esc>",
            },
        },
        filetypes = {
            yaml = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
            -- markdown = false,
        },
    },
}
