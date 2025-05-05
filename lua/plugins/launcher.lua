return {
    "mbwilding/launcher.nvim",
    dev = true,
    config = function()
        local opts = {
            custom_dir = vim.fn.stdpath("config") .. "/lua/launcher"
        }

        local prefix = "Launcher: "

        vim.keymap.set("n", "<leader>lp", function()
            require("launcher").file(opts)
        end, { desc = prefix .. "Picker" })

        vim.keymap.set("n", "<leader>lr", function()
            require("launcher").rerun(opts)
        end, { desc = prefix .. "Rerun" })
    end,
}
