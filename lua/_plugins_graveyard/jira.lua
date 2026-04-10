return {
    "kid-icarus/jira.nvim",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>jv", "<CMD>Jira issue view<CR>", desc = "Jira: Issue view" },
        { "<leader>jc", "<CMD>Jira issue create<CR>", desc = "Jira: Issue create" },
        {
            "<leader>jt",
            function()
                require("jira.pickers.snacks").transitions()
            end,
            desc = "Jira: Transitions",
        },
    },
    opts = {
        use_git_branch_issue_id = true,
        git_trunk_branch = "main",
        git_branch_prefix = "feature/",
    },
}
