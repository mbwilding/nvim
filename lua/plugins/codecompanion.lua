local function codecompanion_prompt(command_prefix)
    vim.ui.input({ prompt = "AI: " }, function(input)
        if input and input ~= "" then
            local prefix = command_prefix and (command_prefix .. " ") or ""
            vim.cmd("CodeCompanion " .. prefix .. input)
        end
    end)
end

return {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        {
            "zbirenbaum/copilot.lua",
            opts = {
                copilot_model = "claude-sonnet-4-5",
                panel = { enabled = false },
                suggestion = { enabled = false },
                nes = { enabled = false },
            },
        },
    },
    keys = {
        {
            "<leader>aia",
            mode = { "n", "v" },
            "<CMD>CodeCompanionActions<CR>",
            desc = "CodeCompanion: Actions",
        },
        {
            "<leader>aic",
            mode = { "n", "v" },
            "<CMD>CodeCompanionChat Toggle<CR>",
            desc = "CodeCompanion: Chat",
        },
        {
            "<leader>aii",
            mode = { "n" },
            function()
                codecompanion_prompt("#{buffer}")
            end,
            desc = "CodeCompanion: Buffer",
        },
        {
            "<leader>aii",
            mode = { "v" },
            function()
                codecompanion_prompt()
            end,
            desc = "CodeCompanion: Selection",
        },
    },
    opts = {
        strategies = {
            chat = {
                adapter = "copilot",
                model = "claude-sonnet-4-5",
            },
            inline = {
                adapter = "copilot",
                model = "claude-sonnet-4-5",
            },
            agent = {
                adapter = "copilot",
                model = "claude-sonnet-4-5",
            },
            cmd = {
                adapter = "copilot",
                model = "claude-sonnet-4-5",
            },
        },
    },
}
