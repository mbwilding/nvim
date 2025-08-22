-- Unreal Engine utilites

vim.pack.add({
    "https://github.com/mbwilding/UnrealEngine.nvim",
}, { confirm = false })

vim.keymap.set("n", "<leader>ug", function()
    require("unrealengine.commands").generate_lsp()
end, { desc = "UnrealEngine: Generate LSP" })

vim.keymap.set("n", "<leader>ub", function()
    require("unrealengine.commands").build()
end, { desc = "UnrealEngine: Build" })

vim.keymap.set("n", "<leader>ur", function()
    require("unrealengine.commands").rebuild()
end, { desc = "UnrealEngine: Rebuild" })

vim.keymap.set("n", "<leader>uo", function()
    require("unrealengine.commands").open()
end, { desc = "UnrealEngine: Open" })

vim.keymap.set("n", "<leader>uc", function()
    require("unrealengine.commands").clean()
end, { desc = "UnrealEngine: Clean" })

local opts = {
    auto_generate = true,
    auto_build = true,
    engine_path = {
        "D:\\UnrealEngine",
        os.getenv("HOME") .. "/dev/UnrealEngine",
    },
}

require("unrealengine").setup(opts)
