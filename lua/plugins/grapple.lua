return {
    "cbochs/grapple.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        scope = "git", -- also "git_branch"
        icons = true,
    },
    event = { "BufReadPost", "BufNewFile" },
    cmd = "Grapple",
    keys = {
        -- { "<leader>K", "<CMD>Grapple toggle_scopes<CR>",  desc = "Grapple toggle scopes" },
        -- { "<leader>j", "<CMD>Grapple cycle forward<CR>",  desc = "Grapple cycle forward" },
        -- { "<leader>J", "<CMD>Grapple cycle backward<CR>", desc = "Grapple cycle backward" },
        { "<leader>a", "<CMD>Grapple toggle<CR>",         desc = "Grapple Toggle" },
        { "<leader>A", "<CMD>Grapple toggle_tags<CR>",    desc = "Grapple Show Tags" },
        { "1",         "<CMD>Grapple select index=1<CR>", desc = "Grapple: Select 1" },
        { "2",         "<CMD>Grapple select index=2<CR>", desc = "Grapple: Select 2" },
        { "3",         "<CMD>Grapple select index=3<CR>", desc = "Grapple: Select 3" },
        { "4",         "<CMD>Grapple select index=4<CR>", desc = "Grapple: Select 4" },
        { "5",         "<CMD>Grapple select index=5<CR>", desc = "Grapple: Select 5" },
        { "6",         "<CMD>Grapple select index=6<CR>", desc = "Grapple: Select 6" },
        { "7",         "<CMD>Grapple select index=7<CR>", desc = "Grapple: Select 7" },
        { "8",         "<CMD>Grapple select index=8<CR>", desc = "Grapple: Select 8" },
        { "9",         "<CMD>Grapple select index=9<CR>", desc = "Grapple: Select 9" },
    },
}
