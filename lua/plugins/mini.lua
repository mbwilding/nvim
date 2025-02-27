-- Collection of various small independent plugins/modules

return {
    "echasnovski/mini.nvim",
    lazy = true,
    event = "BufEnter",
    config = function()
        -- Better Around/Inside textobjects
        --
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({ n_lines = 500 })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        --
        -- Examples:
        --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        --  - sd'   - [S]urround [D]elete [']quotes
        --  - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup()

        -- Allows moving lines or chunks while reindenting
        require("mini.move").setup({
            mappings = {
                -- Normal
                line_left = "<M-h>",
                line_right = "<M-l>",
                line_down = "<M-j>",
                line_up = "<M-k>",
                -- Visual
                left = "<M-h>",
                right = "<M-l>",
                down = "<M-j>",
                up = "<M-k>",
            },
            options = {
                reindent_linewise = true,
            },
        })

        -- Inserts ending bracket and/or quotes
        require("mini.pairs").setup({
            modes = { insert = true, command = false, terminal = false },

            mappings = (function()
                local pair_definitions = {
                    { open = "(", close = ")", pair = "()" },
                    { open = "[", close = "]", pair = "[]" },
                    { open = "{", close = "}", pair = "{}" },
                    { open = "<", close = ">", pair = "<>" },
                }

                local quote_definitions = {
                    { char = '"', pair = '""' },
                    { char = "'", pair = "''" },
                    { char = "`", pair = "``" },
                }

                local mappings = {}

                for _, p in ipairs(pair_definitions) do
                    for _, side in ipairs({ { key = p.open, action = "open" }, { key = p.close, action = "close" } }) do
                        mappings[side.key] = {
                            action = side.action,
                            pair = p.pair,
                            neigh_pattern = "[^" .. vim.fn.escape(side.key, "\\") .. "].",
                        }
                    end
                end

                for _, q in ipairs(quote_definitions) do
                    mappings[q.char] = {
                        action = "closeopen",
                        pair = q.pair,
                        neigh_pattern = "[^" .. vim.fn.escape(q.char, "\\") .. "].",
                        register = { cr = false },
                    }
                end

                return mappings
            end)(),
        })

        require("mini.bracketed").setup()
    end,
}
