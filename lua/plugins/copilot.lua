-- Copilot integration.

return {
    "zbirenbaum/copilot.lua",
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
            enabled = true,
            auto_trigger = true,
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
