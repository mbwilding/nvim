return {
    "mbwilding/launcher.nvim",
    dev = true,
    config = function()
        if jit.os == "Linux" then
            vim.g.unreal_engine_path = os.getenv("HOME") .. "/dev/UnrealEngine"
        else
            vim.g.unreal_engine_path = "/Volumes/SamsungT7/UnrealEngine"
        end

        local prefix = "Launcher: "

        vim.keymap.set("n", "<leader>lp", function()
            require("launcher").file()
        end, { desc = prefix .. "Picker" })

        vim.keymap.set("n", "<leader>lr", function()
            require("launcher").rerun()
        end, { desc = prefix .. "Rerun" })
    end,
}
