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
            controls = {
                enabled = false,
            },
        },
        virtual_text = {
            enabled = true,
        },
        auto_toggle = true,
    },
}
