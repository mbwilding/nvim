return {
    "mbwilding/UnrealEngine.nvim",
    dev = false,
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
    },
    config = function()
        require("unrealengine").setup({
            auto_generate = true,
            auto_build = false,
            engine_path = "/opt/unreal-engine",
            link_plugin = true,
            environment_variables = {
                SDL_VIDEODRIVER = "",
            },
        })
    end,
}
