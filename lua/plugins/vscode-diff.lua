return {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    config = function()
        require("vscode-diff").setup({
            keymaps = {
                view = {
                    quit = "q", -- Close diff tab
                    toggle_explorer = "<leader>e", -- Toggle explorer visibility (explorer mode only)
                    next_hunk = "]c", -- Jump to next change
                    prev_hunk = "[c", -- Jump to previous change
                    next_file = "]f", -- Next file in explorer mode
                    prev_file = "[f", -- Previous file in explorer mode
                    diff_get = "do", -- Get change from other buffer (like vimdiff)
                    diff_put = "dp", -- Put change to other buffer (like vimdiff)
                },
                explorer = {
                    select = "<CR>", -- Open diff for selected file
                    hover = "K", -- Show file diff preview
                    refresh = "R", -- Refresh git status
                    toggle_view_mode = "t", -- Toggle between 'list' and 'tree' views
                },
            },
            diff = {
                disable_inlay_hints = true,
                max_computation_time_ms = 5000,
            },
            explorer = {
                position = "bottom",
                width = 40,
                height = 10,
                indent_markers = false,
                icons = {
                    folder_closed = "",
                    folder_open = "",
                },
                view_mode = "list", -- "list" or "tree"
                file_filter = {
                    ignore = {}, -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
                },
            },
        })
    end,
}
