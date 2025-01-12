-- Copilot integration.

return {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    keys = {
        {
            "<leader>cpt",
            "<CMD>Copilot toggle<CR>",
            desc = "Copilot: Toggle",
        },
        {
            "<leader>cpe",
            "<CMD>Copilot enable<CR>",
            desc = "Copilot: Enable",
        },
        {
            "<leader>cpd",
            "<CMD>Copilot disable<CR>",
            desc = "Copilot: Disable",
        },
    },
    opts = {
        suggestion = {
            enabled = true,
            auto_trigger = true,
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
        panel = { enabled = true },
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
