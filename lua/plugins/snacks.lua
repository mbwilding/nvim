return {
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
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
        image = {},
        dashboard = {
            preset = {
                header = [[
██╗   ██╗██╗███╗   ███╗
██║   ██║██║████╗ ████║
██║   ██║██║██╔████╔██║
╚██╗ ██╔╝██║██║╚██╔╝██║
 ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
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
                    -- { icon = "󱦗 ", key = "M", desc = "Mason", action = ":Mason" },
                    { icon = " ", key = "q", desc = "Quit", action = ":qa" },
                },
            },
            sections = {
                { section = "header" },
                -- { section = "startup" },
                function()
                    local lazy_stats = require("lazy.stats").stats()
                    local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
                    return {
                        align = "center",
                        text = {
                            { "loaded ", hl = "footer" },
                            { lazy_stats.loaded .. "/" .. lazy_stats.count, hl = "special" },
                            { " plugins in ", hl = "footer" },
                            { ms .. "ms", hl = "special" },
                        },
                    }
                end,
            },
        },
        picker = {
            ui_select = true,
            layout = {
                preview = true,
                reverse = true,
                layout = {
                    box = "horizontal",
                    backdrop = false,
                    width = 0.999,
                    height = 0.999,
                    border = "none",
                    {
                        box = "vertical",
                        { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                        {
                            win = "input",
                            height = 1,
                            border = "rounded",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                        },
                    },
                    {
                        win = "preview",
                        title = "{preview:Preview}",
                        width = 0.45,
                        border = "rounded",
                        title_pos = "center",
                    },
                },
            },
            matcher = {
                fuzzy = true, -- use fuzzy matching
                smartcase = true, -- use smartcase
                ignorecase = true, -- use ignorecase
                sort_empty = false, -- sort results when the search string is empty
                filename_bonus = true, -- give bonus for matching file names (last part of the path)
                file_pos = true, -- support patterns like `file:line:col` and `file:line`
                -- the bonusses below, possibly require string concatenation and path normalization,
                -- so this can have a performance impact for large lists and increase memory usage
                cwd_bonus = true, -- give bonus for matching files in the cwd
                frecency = true, -- frecency bonus
            },
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
