---@type zpack.Spec
return {
    "igorlfs/nvim-dap-view",
    lazy = false,
    dependencies = { "mfussenegger/nvim-dap" },
    keys = {
        {
            "<leader>dap",
            "<cmd>DapViewToggle<cr>",
            desc = "Debug: Toggle UI"
        },
    },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
        winbar = {
            sections = {
                "console",
                "watches",
                "scopes",
                "exceptions",
                "breakpoints",
                "threads",
                "repl"
            },
            controls = {
                enabled = true,
            },
            default_section = "console",
            show_keymap_hints = false,
        },
        windows = {
            terminal = {
                hide = true,
            },
        },
        virtual_text = {
            enabled = true,
            position = "eol", -- "eol_right_align"
        },
        auto_toggle = true,
    },
}
