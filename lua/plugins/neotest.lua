return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        -- Test suites
        "rouge8/neotest-rust",
    },
    config = function()
        require("neotest").setup({
            adapters = {
                require("neotest-rust"),
            },
        })

        vim.keymap.set("n", "<leader>ntr", function()
            require("neotest").run.run()
        end, { desc = "Neotest: Run Nearest Test" })

        vim.keymap.set("n", "<leader>ntf", function()
            require("neotest").run.run(vim.fn.expand("%"))
        end, { desc = "Neotest: Run Current File" })

        vim.keymap.set("n", "<leader>ntd", function()
            require("neotest").run.run({ strategy = "dap" })
        end, { desc = "Neotest: Debug Nearest Test" })

        vim.keymap.set("n", "<leader>nts", function()
            require("neotest").run.stop()
        end, { desc = "Neotest: Stop Nearest Test" })

        vim.keymap.set("n", "<leader>nta", function()
            require("neotest").run.attach()
        end, { desc = "Neotest: Attach Nearest Test" })

        vim.keymap.set("n", "<leader>ntw", function()
            require("neotest").watch.watch()
        end, { desc = "Neotest: Watch" })

        vim.keymap.set("n", "<leader>ntt", function()
            require("neotest").watch.toggle()
        end, { desc = "Neotest: Watch Toggle" })

        vim.keymap.set("n", "<leader>ntW", function()
            require("neotest").watch.toggle(vim.fn.expand("%"))
        end, { desc = "Neotest: Watch File" })
    end,
}
