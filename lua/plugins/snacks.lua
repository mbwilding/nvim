---@diagnostic disable: undefined-global

return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 999,
    keys = {
        {
            "<leader>,",
            function()
                Snacks.picker.buffers()
            end,
            desc = "Buffers",
        },
        {
            "<leader>/",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader><leader>",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },
        {
            "<leader>:",
            function()
                Snacks.picker.command_history()
            end,
            desc = "Command History",
        },
        {
            "<leader>ec",
            function()
                ---@diagnostic disable-next-line: missing-fields, assign-type-mismatch
                Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = "Find Config File",
        },
        {
            "<leader>fg",
            function()
                Snacks.picker.git_files()
            end,
            desc = "Find Git Files",
        },
        {
            "<leader>fr",
            function()
                Snacks.picker.recent()
            end,
            desc = "Recent",
        },
        -- git
        {
            "<leader>gc",
            function()
                Snacks.picker.git_log()
            end,
            desc = "Git Log",
        },
        {
            "<leader>gs",
            function()
                Snacks.picker.git_status()
            end,
            desc = "Git Status",
        },
        -- Grep
        {
            "<leader>sb",
            function()
                Snacks.picker.lines()
            end,
            desc = "Buffer Lines",
        },
        {
            "<leader>sB",
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = "Grep Open Buffers",
        },
        {
            "<leader>sg",
            function()
                Snacks.picker.grep()
            end,
            desc = "Grep",
        },
        {
            "<leader>sw",
            function()
                Snacks.picker.grep_word()
            end,
            desc = "Visual selection or word",
            mode = { "n", "x" },
        },
        -- search
        {
            "<leader>s\"",
            function()
                Snacks.picker.registers()
            end,
            desc = "Registers",
        },
        {
            "<leader>sa",
            function()
                Snacks.picker.autocmds()
            end,
            desc = "Autocmds",
        },
        {
            "<leader>sC",
            function()
                Snacks.picker.commands()
            end,
            desc = "Commands",
        },
        {
            "<leader>sd",
            function()
                Snacks.picker.diagnostics()
            end,
            desc = "Diagnostics",
        },
        {
            "<leader>sh",
            function()
                Snacks.picker.help()
            end,
            desc = "Help Pages",
        },
        {
            "<leader>sH",
            function()
                Snacks.picker.highlights()
            end,
            desc = "Highlights",
        },
        {
            "<leader>sj",
            function()
                Snacks.picker.jumps()
            end,
            desc = "Jumps",
        },
        {
            "<leader>sk",
            function()
                Snacks.picker.keymaps()
            end,
            desc = "Keymaps",
        },
        {
            "<leader>sl",
            function()
                Snacks.picker.loclist()
            end,
            desc = "Location List",
        },
        {
            "<leader>sM",
            function()
                Snacks.picker.man()
            end,
            desc = "Man Pages",
        },
        {
            "<leader>sm",
            function()
                Snacks.picker.marks()
            end,
            desc = "Marks",
        },
        {
            "<leader>sR",
            function()
                Snacks.picker.resume()
            end,
            desc = "Resume",
        },
        {
            "<leader>sq",
            function()
                Snacks.picker.qflist()
            end,
            desc = "Quickfix List",
        },
        {
            "<leader>uC",
            function()
                Snacks.picker.colorschemes()
            end,
            desc = "Colorschemes",
        },
        {
            "<leader>qp",
            function()
                Snacks.picker.projects()
            end,
            desc = "Projects",
        },
        -- LSP
        {
            "gd",
            function()
                Snacks.picker.lsp_definitions()
            end,
            desc = "Goto Definition",
        },
        {
            "gr",
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = "References",
        },
        {
            "gI",
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = "Goto Implementation",
        },
        {
            "gy",
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = "Goto T[y]pe Definition",
        },
        {
            "<leader>ss",
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = "LSP Symbols",
        },
    },
    opts = {
        dashboard = {
            preset = {
                keys = {
                    { icon = " ", key = "e", desc = "New File", action = ":ene | startinsert" },
                    {
                        icon = " ",
                        key = "<leader><leader>",
                        desc = "Find File",
                        action = ":lua Snacks.dashboard.pick('files')",
                    },
                    {
                        icon = " ",
                        key = "<leader>/",
                        desc = "Find Text",
                        action = ":lua Snacks.dashboard.pick('grep')",
                    },
                    {
                        icon = " ",
                        key = "r",
                        desc = "Recent Files",
                        action = ":lua Snacks.dashboard.pick('oldfiles')",
                    },
                    {
                        icon = " ",
                        key = "c",
                        desc = "Config",
                        action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
                    },
                    -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                    {
                        icon = "󰒲 ",
                        key = "L",
                        desc = "Lazy",
                        action = ":Lazy",
                        enabled = package.loaded.lazy ~= nil,
                    },
                    { icon = "󱦗 ", key = "M", desc = "Mason", action = ":Mason" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                { section = "keys",  gap = 1, padding = 1 },
                {
                    pane = 2,
                    icon = " ",
                    desc = "Browse Repo",
                    padding = 1,
                    key = "b",
                    action = function()
                        Snacks.gitbrowse()
                    end,
                },
                function()
                    local in_git = Snacks.git.get_root() ~= nil
                    local origin = vim.trim(vim.fn.system("git config --get remote.origin.url"))
                    local is_gh = origin:match("github.com") ~= nil
                    local is_azdo = origin:match("dev.azure.com") ~= nil

                    local organization, project, repository
                    if is_azdo then
                        organization, project, repository = origin:match("v3/([^/]+)/([^/]+)/([^/]+)")
                    elseif is_gh then
                        project = ""
                        organization, repository = origin:match("github.com[:/]([^/]+)/([^/]+)")
                    end
                    local cmds = {
                        -- GitHub
                        {
                            title = "Notifications",
                            cmd = "gh notify -s -a -n5",
                            action = function()
                                vim.ui.open("https://github.com/notifications")
                            end,
                            key = "n",
                            icon = " ",
                            height = 5,
                            enabled = is_gh,
                        },
                        {
                            title = "Open Issues",
                            cmd = "gh issue list -L 3",
                            key = "i",
                            action = function()
                                vim.fn.jobstart("gh issue list --web", { detach = true })
                            end,
                            icon = " ",
                            height = 7,
                            enabled = is_gh,
                        },
                        {
                            icon = " ",
                            title = "Open PRs",
                            cmd = "gh pr list -L 3",
                            key = "p",
                            action = function()
                                vim.fn.jobstart("gh pr list --web", { detach = true })
                            end,
                            height = 7,
                            enabled = is_gh,
                        },
                        -- Azure DevOps
                        {
                            icon = " ",
                            title = "Open PRs",
                            cmd = "az repos pr list --top 7"
                                .. " --organization https://dev.azure.com/" .. organization
                                .. " --project " .. project
                                .. " --repository " .. repository
                                .. " | jq -r '.[] | \"\\(.title) | \\(.sourceRefName | sub(\"refs/heads/\"; \"\"))\"'",
                            key = "p",
                            action = function()
                                vim.ui.open("https://dev.azure.com/" ..
                                organization .. "/" .. project .. "/_git/" .. repository .. "/pullrequests")
                            end,
                            height = 7,
                            enabled = is_azdo,
                        },
                        -- Git
                        {
                            icon = " ",
                            title = "Git Status",
                            cmd = "git --no-pager diff --stat -B -M -C",
                            height = 10,
                        },
                    }
                    return vim.tbl_map(function(cmd)
                        return vim.tbl_extend("force", {
                            pane = 2,
                            section = "terminal",
                            enabled = in_git,
                            padding = 1,
                            ttl = 5 * 60,
                            indent = 3,
                        }, cmd)
                    end, cmds)
                end,
                { section = "startup" },
            },
        },
        picker = {
            sources = {
                files = {
                    hidden = true,
                },
                grep = {
                    hidden = true,
                },
            },
        },
    },
}
