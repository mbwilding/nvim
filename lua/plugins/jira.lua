return {
    "kid-icarus/jira.nvim",
    -- lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
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

        local t = require("telescope")
        vim.keymap.set("n", "<leader>jv", "<cmd>Jira issue view<cr>", { desc = "Jira: Issue view" })
        vim.keymap.set("n", "<leader>jt", t.extensions.jira.transitions, { desc = "Jira: Transitions" })
        vim.keymap.set("n", "<leader>jc", "<cmd>Jira issue create<cr>", { desc = "Jira: Issue create" })
    end,
}
