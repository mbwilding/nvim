return {
    "igorlfs/nvim-dap-view",
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
    config = function(_, opts)
        require("dap-view").setup(opts)

        local dap = require("dap")
        dap.listeners.before.attach.dapui_config = function()
            vim.cmd("DapViewOpen")
        end
        dap.listeners.before.launch.dapui_config = function()
            vim.cmd("DapViewOpen")
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            vim.cmd("DapViewClose")
        end
        dap.listeners.before.event_exited.dapui_config = function()
            vim.cmd("DapViewClose")
        end
    end,
}
