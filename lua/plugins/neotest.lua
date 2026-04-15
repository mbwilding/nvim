return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Test suites
        "rouge8/neotest-rust",
        "Issafalcon/neotest-dotnet",
    },
    keys = {
        {
            "<leader>ntr",
            function()
                require("neotest").run.run()
            end,
            desc = "Neotest: Run Nearest Test",
        },
        {
            "<leader>ntf",
            function()
                require("neotest").run.run(vim.fn.expand("%"))
            end,
            desc = "Neotest: Run Current File",
        },
        {
            "<leader>ntd",
            function()
                require("neotest").run.run({ strategy = "dap" })
            end,
            desc = "Neotest: Debug Nearest Test",
        },
        {
            "<leader>nts",
            function()
                require("neotest").run.stop()
            end,
            desc = "Neotest: Stop Nearest Test",
        },
        {
            "<leader>nta",
            function()
                require("neotest").run.attach()
            end,
            desc = "Neotest: Attach Nearest Test",
        },
        {
            "<leader>ntw",
            function()
                require("neotest").watch.watch()
            end,
            desc = "Neotest: Watch",
        },
        {
            "<leader>ntt",
            function()
                require("neotest").watch.toggle()
            end,
            desc = "Neotest: Watch Toggle",
        },
        {
            "<leader>ntW",
            function()
                require("neotest").watch.toggle(vim.fn.expand("%"))
            end,
            desc = "Neotest: Watch File",
        },
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-rust"),
                require("neotest-dotnet")({
                    dap = {
                        adapter_name = "netcoredbg",
                    },
                    discovery_root = "solution",
                }),
            },
        })
    end,
}
