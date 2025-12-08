return {
    "olimorris/codecompanion.nvim",
    version = "v17.33.0",
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
    config = function(_, opts)
        require("codecompanion").setup(opts)

        vim.keymap.set(
            { "n", "v" },
            "<leader>aia",
            "<CMD>CodeCompanionActions<CR>",
            { desc = "CodeCompanion: Actions" }
        )
        vim.keymap.set(
            { "n", "v" },
            "<leader>aic",
            "<CMD>CodeCompanionChat Toggle<CR>",
            { desc = "CodeCompanion: Chat" }
        )

        local function codecompanion_prompt(command_prefix)
            vim.ui.input({ prompt = "AI: " }, function(input)
                if input and input ~= "" then
                    local prefix = command_prefix and (command_prefix .. " ") or ""
                    vim.cmd("CodeCompanion " .. prefix .. input)
                end
            end)
        end

        vim.keymap.set("n", "<leader>aii", function()
            codecompanion_prompt("#buffer")
        end, { desc = "CodeCompanion: Buffer" })

        vim.keymap.set("v", "<leader>aii", function()
            codecompanion_prompt()
        end, { desc = "CodeCompanion: Selection" })
    end,
}
