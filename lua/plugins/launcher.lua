return {
    "mbwilding/launcher.nvim",
    dev = true,
    config = function()
        vim.g.unreal_engine_path = os.getenv("HOME") .. "/dev/UnrealEngine"

        local prefix = "Launcher: "

        vim.keymap.set("n", "<leader>lp", function()
            require("launcher").file()
        end, { desc = prefix .. "Picker" })

        vim.keymap.set("n", "<leader>lr", function()
            require("launcher").rerun()
        end, { desc = prefix .. "Rerun" })
    end,
}
