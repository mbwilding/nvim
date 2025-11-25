local uname = vim.loop.os_uname()

local engine_path = uname.sysname == "Windows_NT" and [[D:\unreal-engine]] or "/mnt/studio/unreal-engine"

local is_android
if uname.release:lower():find("android") or uname.version:lower():find("android") then
    is_android = true
end

return {
    "mbwilding/UnrealEngine.nvim",
    lazy = false,
    dev = true,
    enabled = not is_android,
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
            },
        })
    end,
}
