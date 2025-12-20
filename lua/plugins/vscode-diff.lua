return {
    "esmuellert/vscode-diff.nvim",
    branch = "next",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "folke/snacks.nvim", -- For custom logic below
    },
    event = "VeryLazy",
    cmd = "CodeDiff",
    keys = {
        {
            "<leader>cd",
            "<CMD>CodeDiff<CR>",
            desc = "Code Diff",
        },
    },
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

        local Snacks = require("snacks")

        local function walk_in_codediff(picker, item)
            picker:close()
            if item.commit then
                local current_commit = item.commit

                vim.fn.setreg("+", current_commit)
                vim.notify("Copied: " .. current_commit)
                -- get parent / previous commit
                local parent_commit = vim.trim(vim.fn.system("git rev-parse --short " .. current_commit .. "^"))
                parent_commit = parent_commit:match("[a-f0-9]+")
                -- Check if command failed (e.g., Initial commit has no parent)
                if vim.v.shell_error ~= 0 then
                    vim.notify("Cannot find parent (Root commit?)", vim.log.levels.WARN)
                    parent_commit = ""
                end
                local cmd = string.format("CodeDiff %s %s", parent_commit, current_commit)
                vim.notify("Diffing: " .. parent_commit .. " -> " .. current_commit)
                vim.cmd(cmd)
            end
        end

        local function git_pickaxe(opts)
            opts = opts or {}
            local is_global = opts.global or false
            local current_file = vim.api.nvim_buf_get_name(0)
            -- Force global if current buffer is invalid
            if not is_global and (current_file == "" or current_file == nil) then
                vim.notify("Buffer is not a file, switching to global search", vim.log.levels.WARN)
                is_global = true
            end

            local title_scope = is_global and "Global" or vim.fn.fnamemodify(current_file, ":t")
            vim.ui.input({ prompt = "Git Search (-G) in " .. title_scope .. ": " }, function(query)
                if not query or query == "" then
                    return
                end

                -- set keyword highlight within Snacks.picker
                vim.fn.setreg("/", query)
                local old_hl = vim.opt.hlsearch
                vim.opt.hlsearch = true

                local args = {
                    "log",
                    "-G" .. query,
                    "-i",
                    "--pretty=format:%C(yellow)%h%Creset %s %C(green)(%cr)%Creset %C(blue)<%an>%Creset",
                    "--abbrev-commit",
                    "--date=short",
                }

                if not is_global then
                    table.insert(args, "--")
                    table.insert(args, current_file)
                end

                Snacks.picker({
                    title = "Git Log: \"" .. query .. "\" (" .. title_scope .. ")",
                    finder = "proc",
                    cmd = "git",
                    args = args,

                    transform = function(item)
                        local clean_text = item.text:gsub("\27%[[0-9;]*m", "")
                        local hash = clean_text:match("^%S+")
                        if hash then
                            item.commit = hash
                            if not is_global then
                                item.file = current_file
                            end
                        end
                        return item
                    end,

                    preview = "git_show",
                    confirm = walk_in_codediff,
                    format = "text",

                    on_close = function()
                        -- remove keyword highlight
                        vim.opt.hlsearch = old_hl
                        vim.cmd("noh")
                    end,
                })
            end)
        end

        -- Keymaps
        vim.keymap.set("n", "<leader>gy", function()
            git_pickaxe({ global = false })
        end, { desc = "Code Diff: Git Search (Buffer)" })

        vim.keymap.set("n", "<leader>gY", function()
            git_pickaxe({ global = true })
        end, { desc = "Code Diff: Git Search (Global)" })

        vim.keymap.set({ "n", "t" }, "<leader>gf", function()
            Snacks.picker.git_log_file({
                confirm = walk_in_codediff,
            })
        end, { desc = "Code Diff: Find Git Log File" })

        vim.keymap.set({ "n", "t" }, "<leader>gF", function()
            Snacks.picker.git_log({
                confirm = walk_in_codediff,
            })
        end, { desc = "Code Diff: Find Git Log" })

        -- Revision
        vim.keymap.set("n", "<leader>gr", function()
            Snacks.picker({
                title = "Git Revisions",
                finder = "proc",
                cmd = "git",
                args = {
                    "log",
                    "--pretty=format:%C(yellow)%h%Creset %s %C(green)(%cr)%Creset %C(blue)<%an>%Creset",
                    "--abbrev-commit",
                    "--date=short",
                },
                transform = function(item)
                    local clean_text = item.text:gsub("\27%[[0-9;]*m", "")
                    local hash = clean_text:match("^%S+")
                    if hash then
                        item.commit = hash
                    end
                    return item
                end,
                preview = "git_show",
                confirm = function(picker, item)
                    picker:close()
                    if item.commit then
                        vim.notify("Diffing against revision: " .. item.commit)
                        vim.cmd("CodeDiff " .. item.commit)
                    end
                end,
                format = "text",
            })
        end, { desc = "Code Diff: Current <-> Revision" })

        -- Branch
        vim.keymap.set("n", "<leader>gb", function()
            Snacks.picker({
                title = "Git Branches",
                finder = "proc",
                cmd = "git",
                args = { "branch", "--all", "--color=never" },
                layout = {
                    preview = false,
                },
                transform = function(item)
                    local branch = item.text:gsub("^%*?%s*", ""):gsub("^remotes/", "")
                    item.branch = branch
                    return item
                end,
                confirm = function(picker, item)
                    picker:close()
                    if item.branch then
                        local branch = item.branch
                        vim.notify("Diffing against branch: " .. branch)
                        vim.cmd("CodeDiff " .. branch)
                    end
                end,
                format = "text",
            })
        end, { desc = "Code Diff: Current <-> Branch" })
    end,
}
