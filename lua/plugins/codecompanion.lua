return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {
        strategies = {
            chat = {
                adapter = "openai",
            },
            inline = {
                adapter = "openai",
            },
            cmd = {
                adapter = "openai",
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
