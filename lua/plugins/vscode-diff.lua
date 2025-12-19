return {
    "esmuellert/vscode-diff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    config = function()
        require("vscode-diff").setup({
            -- Diff view behavior
            diff = {
                disable_inlay_hints = true,
                max_computation_time_ms = 5000,
            },
            -- Explorer panel configuration
            explorer = {
                position = "left", -- "left" or "bottom"
                width = 40, -- Width when position is "left" (columns)
                height = 15, -- Height when position is "bottom" (lines)
                indent_markers = true, -- Show indent markers in tree view (│, ├, └)
                icons = {
                    folder_closed = "", -- Nerd Font folder icon (customize as needed)
                    folder_open = "", -- Nerd Font folder-open icon
                },
                view_mode = "list", -- "list" or "tree"
                file_filter = {
                    ignore = {}, -- Glob patterns to hide (e.g., {"*.lock", "dist/*"})
                },
            },
            -- Keymaps in diff view
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
        })
    end,
}
