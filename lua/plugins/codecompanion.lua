-- AI

vim.pack.add({
    "https://github.com/olimorris/codecompanion.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
}, { confirm = false })

local opts = {
    strategies = {
        chat = {
            adapter = "openai",
        },
        inline = {
            adapter = "openai",
        },
    },
}

require("codecompanion").setup(opts)

local function codecompanion_prompt(command_prefix)
    vim.ui.input({ prompt = "AI: " }, function(input)
        if input and input ~= "" then
            local prefix = command_prefix and (command_prefix .. " ") or ""
            vim.cmd("CodeCompanion " .. prefix .. input)
        end
    end)
end

vim.keymap.set({ "n", "v" }, "<leader>aia", "<CMD>CodeCompanionActions<CR>", { desc = "CodeCompanion: Actions" })
vim.keymap.set({ "n", "v" }, "<leader>aic", "<CMD>CodeCompanionChat Toggle<CR>", { desc = "CodeCompanion: Chat" })

vim.keymap.set("n", "<leader>aii", function()
    codecompanion_prompt("#buffer")
end, { desc = "CodeCompanion: Buffer" })

vim.keymap.set("v", "<leader>aii", function()
    codecompanion_prompt()
end, { desc = "CodeCompanion: Selection" })
