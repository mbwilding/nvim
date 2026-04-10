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
        { "<leader>a", "<CMD>Grapple toggle<CR>", desc = "Grapple Toggle" },
        { "<leader>A", "<CMD>Grapple toggle_tags<CR>", desc = "Grapple Show Tags" },
        { "<leader>1", "<CMD>Grapple select index=1<CR>", desc = "Grapple: Select 1" },
        { "<leader>2", "<CMD>Grapple select index=2<CR>", desc = "Grapple: Select 2" },
        { "<leader>3", "<CMD>Grapple select index=3<CR>", desc = "Grapple: Select 3" },
        { "<leader>4", "<CMD>Grapple select index=4<CR>", desc = "Grapple: Select 4" },
        { "<leader>5", "<CMD>Grapple select index=5<CR>", desc = "Grapple: Select 5" },
        { "<leader>6", "<CMD>Grapple select index=6<CR>", desc = "Grapple: Select 6" },
        { "<leader>7", "<CMD>Grapple select index=7<CR>", desc = "Grapple: Select 7" },
        { "<leader>8", "<CMD>Grapple select index=8<CR>", desc = "Grapple: Select 8" },
        { "<leader>9", "<CMD>Grapple select index=9<CR>", desc = "Grapple: Select 9" },
    },
}
