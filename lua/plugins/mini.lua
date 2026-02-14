return {
    "nvim-mini/mini.nvim",
    version = false,
    lazy = false,
    -- event = "BufEnter",
    config = function()
        -- Better Around/Inside textobjects
        -- Examples:
        --  - va)  - [V]isually select [A]round [)]paren
        --  - yinq - [Y]ank [I]nside [N]ext [']quote
        --  - ci'  - [C]hange [I]nside [']quote
        require("mini.ai").setup({
            n_lines = 500,
        })

        -- Add/delete/replace surroundings (brackets, quotes, etc.)
        -- Examples:
        --  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
        --  - sd'   - [S]urround [D]elete [']quotes
        --  - sr)'  - [S]urround [R]eplace [)] [']
        require("mini.surround").setup({})

        -- Move code around
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

        -- Git line number colors
        require("mini.diff").setup()

        -- Auto-pairs
        require("mini.pairs").setup({
            modes = {
                insert = true,
                command = false,
                terminal = false,
            },
            mappings = {
                ["\""] = { action = "closeopen", pair = "\"\"", neigh_pattern = "^[^\\]", register = { cr = false } },
                ["'"] = { action = "closeopen", pair = "''", neigh_pattern = "^[^%a\\]", register = { cr = false } },
                ["`"] = { action = "closeopen", pair = "``", neigh_pattern = "^[^\\]", register = { cr = false } },
                ["("] = { action = "open", pair = "()", neigh_pattern = "^[^\\]" },
                [")"] = { action = "close", pair = "()", neigh_pattern = "^[^\\]" },
                ["["] = { action = "open", pair = "[]", neigh_pattern = "^[^\\]" },
                ["]"] = { action = "close", pair = "[]", neigh_pattern = "^[^\\]" },
                ["{"] = { action = "open", pair = "{}", neigh_pattern = "^[^\\]" },
                ["}"] = { action = "close", pair = "{}", neigh_pattern = "^[^\\]" },
                ["<"] = { action = "open", pair = "<>", neigh_pattern = "^[^%s\\]" },
                [">"] = { action = "close", pair = "<>", neigh_pattern = "^[^%s\\]" },
            },
        })
    end,
}
