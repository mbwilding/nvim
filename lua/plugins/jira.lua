return {
    -- "kid-icarus/jira.nvim",
    "mbwilding/jira.nvim",
    -- lazy = true,
    dev = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {
        jira_api = {
            domain = vim.env.JIRA_DOMAIN,
            username = vim.env.JIRA_USER,
            token = vim.env.JIRA_API_TOKEN,
        },
        use_git_branch_issue_id = true,
        git_trunk_branch = "main", -- The main branch of your project
        git_branch_prefix = "feature/", -- The prefix for your feature branches
    },
    config = function(_, opts)
        require("jira").setup(opts)

        vim.keymap.set("n", "<leader>jv", "<cmd>Jira issue view<cr>", { desc = "Jira: Issue view" })
        vim.keymap.set("n", "<leader>jc", "<cmd>Jira issue create<cr>", { desc = "Jira: Issue create" })
        vim.keymap.set('n', '<leader>jt', require("jira.pickers.snacks").transitions, { desc = "Jira: Transitions"})
    end,
}
