return {
    "mbwilding/launcher.nvim",
    dev = true,
    config = function()
        vim.keymap.set("n", "<leader><esc>", function()
            require("launcher").run()
        end, { desc = "Launcher" })
    end,
}
