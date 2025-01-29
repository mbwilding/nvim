return {
    "kid-icarus/jira.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>jv", "<cmd>Jira issue view<cr>", desc = "Jira: Issue view" },
        { "<leader>jc", "<cmd>Jira issue create<cr>", desc = "Jira: Issue create" },
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
