return {
    "folke/which-key.nvim",
    opts = {},
    config = function()
        require("which-key").register()
        -- Normal
        -- require("which-key").register({
        -- 	["<leader>R"] = { name = "[R]ename", _ = "which_key_ignore" },
        -- 	["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
        -- })

        -- Visual
        -- require("which-key").register({
        -- 	["<leader>"] = { name = "VISUAL <leader>" },
        -- 	["<leader>h"] = { "Git [H]unk" },
        -- }, { mode = "v" })
    end,
}
