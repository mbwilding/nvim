local opts = {
    custom_dir = vim.fn.stdpath("config") .. "/lua/launcher",
}

return {
    "mbwilding/launcher.nvim",
    dependiencies = {
        "folke/snacks.nvim"
    },
    lazy = true,
    dev = true,
    keys = {
        {
            "<leader>lp",
            function()
                require("launcher").file(opts)
            end,
            desc = "Launcher: File",
        },
        {
            "<leader>lr",
            function()
                require("launcher").rerun(opts)
            end,
            desc = "Launcher: Rerun",
        },
    },
}
