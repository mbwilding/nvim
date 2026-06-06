---@type zpack.Spec
return {
    "igorlfs/nvim-dap-view",
    dependencies = { "mfussenegger/nvim-dap" },
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {
        winbar = {
            controls = {
                enabled = true,
            },
        },
        virtual_text = {
            enabled = true,
        },
        -- Auto open when a session starts, auto close when all sessions finish
        auto_toggle = true,
    },
    config = function(_, opts)
        require("dap-view").setup(opts)

        vim.keymap.set("n", "<leader>dap", "<cmd>DapViewToggle<cr>", { desc = "Debug: Toggle UI" })
    end,
}
