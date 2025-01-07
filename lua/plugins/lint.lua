return {
    "mfussenegger/nvim-lint",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")
        local util = require("lint.util")

        -- NOTE: Fixes line 1 error about no config found
        lint.linters.eslint_d = util.wrap(lint.linters.eslint_d, function(diagnostic)
            if diagnostic.message:find("Error: Could not find config file") then
                return nil
            end
            return diagnostic
        end)

        local eslint = lint.linters.eslint_d
        eslint.args = {
            "--no-warn-ignored",
            "--format",
            "json",
            "--stdin",
            "--stdin-filename",
            function()
                return vim.api.nvim_buf_get_name(0)
            end,
        }

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            python = { "pylint" },
            yaml = { "yamllint" }, -- "cfn_lint", "cfn_nag"
        }

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint", { clear = true }),
            callback = function()
                lint.try_lint()
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Lint: Current file" })
    end,
}
