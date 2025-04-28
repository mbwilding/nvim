return {
    "mbwilding/launcher.nvim",
    dev = true,
    config = function()
        vim.g.unreal_engine_path = os.getenv("HOME") .. "/dev/UnrealEngine"

        vim.keymap.set("n", "<leader><esc>", function()
            require("launcher").run()
        end, { desc = "Launcher" })
    end,
}
