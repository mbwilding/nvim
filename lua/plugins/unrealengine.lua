return {
    "mbwilding/UnrealEngine.nvim",
    dev = true,
    lazy = false,
    keys = {
        {
            "<leader>ug",
            function()
                require("unrealengine.commands").generate_lsp()
            end,
            desc = "UnrealEngine: Generate LSP",
        },
        {
            "<leader>ub",
            function()
                require("unrealengine.commands").build()
            end,
            desc = "UnrealEngine: Build",
        },
    },
    config = function()
        require("unrealengine").setup({
            auto_generate = true,
            auto_build = true,
            engine_path = {
                "D:\\UnrealEngine",
                os.getenv("HOME") .. "/dev/UnrealEngine",
                "/Volumes/SamsungT7/UnrealEngine",
            },
        })
    end,
}
