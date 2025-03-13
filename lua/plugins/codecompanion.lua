return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        {
            "<leader>aia",
            "<CMD>CodeCompanionActions<CR>",
            desc = "CodeCompanion: Actions",
            mode = { "n", "v" },
        },
        {
            "<leader>aic",
            "<CMD>CodeCompanionChat Toggle<CR>",
            desc = "CodeCompanion: Chat",
            mode = { "n", "v" },
        },
    },
    opts = {
        system_prompt = function(opts)
            return "Only display the code if it is related to coding or simply answer the question directly, without unnecessary talking."
        end,
        adapters = {
            openai = function()
                return require("codecompanion.adapters").extend("openai", {
                    schema = {
                        model = {
                            default = "o3-mini",
                        },
                    },
                })
            end,
        },
        strategies = {
            chat = {
                adapter = "openai",
            },
            inline = {
                adapter = "openai",
                language = "English",
                -- layout = "vertical",
                keymaps = {
                    accept_change = {
                        modes = { n = "ga" },
                        description = "Accept the suggested change",
                    },
                    reject_change = {
                        modes = { n = "gr" },
                        description = "Reject the suggested change",
                    },
                },
            },
        },
    },
    config = function(_, opts)
        require("codecompanion").setup(opts)
        vim.cmd([[cab cc CodeCompanion]])
    end,
}
