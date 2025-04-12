return {
    "mbwilding/launcher.nvim",
    dev = true,
    config = function()
        vim.keymap.set("n", "<leader>0", function()
            require("launcher").run()
        end, { desc = "Launcher" })
    end,
}
