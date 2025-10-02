-- DiffView is a single tabpage interface for easily cycling through diffs for all modified files for any git rev.

return {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = {
        "DiffviewClose",
        "DiffviewFileHistory",
        "DiffviewFocusFiles",
        "DiffviewLog",
        "DiffviewOpen",
        "DiffviewRefresh",
        "DiffviewToggleFiles",
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        {
            "<leader>dvm",
            "<cmd>DiffviewOpen<CR>",
            desc = "Diffview: Open Merge/Rebase",
        },
        {
            "<leader>dvh",
            "<cmd>DiffviewFileHistory %<CR>",
            desc = "Diffview: Current File History",
        },
        {
            "<leader>dvH",
            "<cmd>DiffviewFileHistory<CR>",
            desc = "Diffview: Repo File History",
        },
        {
            "<leader>dvf",
            "<cmd>DiffviewToggleFiles<CR>",
            desc = "Diffview: Toggle File Panel",
        },
        {
            "<leader>dvF",
            "<cmd>DiffviewFocusFiles<CR>",
            desc = "Diffview: Focus File Panel",
        },
        {
            "<leader>dvr",
            "<cmd>DiffviewRefresh<CR>",
            desc = "Diffview: Refresh",
        },
    },
    opts = {
        hooks = {
            diff_buf_win_enter = function()
                vim.opt_local.foldenable = true
            end,
        },
    },
}
