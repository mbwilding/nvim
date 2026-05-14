local uname = vim.loop.os_uname()

local engine_path = uname.sysname == "Windows_NT" and [[C:\UE\UE_5.7]] or vim.fn.expand('~') .. '/UnrealEngine'

return {
    "mbwilding/UnrealEngine.nvim",
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
        {
            "<leader>ur",
            function()
                require("unrealengine.commands").rebuild()
            end,
            desc = "UnrealEngine: Rebuild",
        },
        {
            "<leader>uo",
            function()
                require("unrealengine.commands").open()
            end,
            desc = "UnrealEngine: Open",
        },
        {
            "<leader>uc",
            function()
                require("unrealengine.commands").clean()
            end,
            desc = "UnrealEngine: Clean",
        },
        {
            "<leader>ul",
            function()
                require("unrealengine.commands").link_plugin()
            end,
            desc = "UnrealEngine: Link Plugin",
        },
        {
            "<leader>ue",
            function()
                require("unrealengine.commands").build_engine()
            end,
            desc = "UnrealEngine: Link Plugin - Build Engine",
        },
        {
            "<leader>up",
            function()
                require("unrealengine.commands").build_plugin()
            end,
            desc = "UnrealEngine: Build Plugin"
        },
    },
    build = function()
        require("unrealengine.commands").build_engine({ engine_path = engine_path })
    end,
    config = function()
        require("unrealengine").setup({
            auto_generate = true,
            auto_build = false,
            engine_path = engine_path,
            link_plugin = true,
            environment_variables = {
                -- SDL_VIDEODRIVER = "",
                VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json",
            },
        })
    end,
}
