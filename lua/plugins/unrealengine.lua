return {
    "mbwilding/UnrealEngine.nvim",
    dev = true,
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
                require("unrealengine.commands").generate_lsp()
            end,
            desc = "UnrealEngine: Build",
        },
    },
    config = function()
        local engine_path
        if jit.os == "Linux" then
            engine_path = os.getenv("HOME") .. "/dev/UnrealEngine"
        elseif jit.os == "OSX" then
            engine_path = "/Volumes/SamsungT7/UnrealEngine"
        elseif jit.os == "Windows" then
            engine_path = "D:\\UnrealEngine"
        end

        require("unrealengine").setup({
            engine_path = engine_path,
        })
    end,
}
