return {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
        winbar = {
            show = true,
            sections = { "breakpoints", "exceptions", "watches", "repl", "threads", "console", "scopes" },
            -- Must be one of the sections declared above
            default_section = "console",
        },
        windows = {
            height = 12,
        },
    },
}
