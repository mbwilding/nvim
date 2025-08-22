-- Fuzzy finding

vim.pack.add({
    "folke/snacks.nvim",
}, { confirm = false })

vim.keymap.set("n", "<leader>,", function()
    Snacks.picker.buffers()
end, { desc = "Snacks: Buffers" })

vim.keymap.set("n", "<leader>/", function()
    Snacks.picker.grep()
end, { desc = "Snacks: Grep" })

vim.keymap.set("n", "<leader><leader>", function()
    Snacks.picker.files()
end, { desc = "Snacks: Files" })

vim.keymap.set("n", "<leader>:", function()
    Snacks.picker.command_history()
end, { desc = "Snacks: Command History" })

vim.keymap.set("n", "<leader>ec", function()
    Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Snacks: Config Files" })

vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.git_files()
end, { desc = "Snacks: Git Files" })

vim.keymap.set("n", "<leader>fg", function()
    Snacks.picker.recent()
end, { desc = "Snacks: Recent Files" })

vim.keymap.set("n", "<leader>gl", function()
    Snacks.picker.git_log()
end, { desc = "Snacks: Git Log" })

vim.keymap.set("n", "<leader>gs", function()
    Snacks.picker.git_log()
end, { desc = "Snacks: Git Status" })

vim.keymap.set("n", "<leader>sb", function()
    Snacks.picker.lines()
end, { desc = "Snacks: Search Buffer" })

vim.keymap.set("n", "<leader>sB", function()
    Snacks.picker.grep_buffers()
end, { desc = "Snacks: Grep Open Buffers" })

vim.keymap.set("n", "<leader>sg", function()
    Snacks.picker.grep()
end, { desc = "Snacks: Grep" })

vim.keymap.set({ "n", "x" }, "<leader>sw", function()
    Snacks.picker.grep_word()
end, { desc = "Snacks: Visual selection or word" })

vim.keymap.set("n", "<leader>s\"", function()
    Snacks.picker.registers()
end, { desc = "Snacks: Registers" })

vim.keymap.set("n", "<leader>sa", function()
    Snacks.picker.autocmds()
end, { desc = "Snacks: Autocmds" })

vim.keymap.set("n", "<leader>sC", function()
    Snacks.picker.commands()
end, { desc = "Snacks: Commands" })

vim.keymap.set("n", "<leader>sd", function()
    Snacks.picker.diagnostics()
end, { desc = "Snacks: Diagnostics" })

vim.keymap.set("n", "<leader>sh", function()
    Snacks.picker.help()
end, { desc = "Snacks: Help Pages" })

vim.keymap.set("n", "<leader>sH", function()
    Snacks.picker.highlights()
end, { desc = "Snacks: Highlights" })

vim.keymap.set("n", "<leader>sj", function()
    Snacks.picker.jumps()
end, { desc = "Snacks: Jumps" })

vim.keymap.set("n", "<leader>sk", function()
    Snacks.picker.keymaps()
end, { desc = "Snacks: Keymaps" })

vim.keymap.set("n", "<leader>sl", function()
    Snacks.picker.loclist()
end, { desc = "Snacks: Location List" })

vim.keymap.set("n", "<leader>sM", function()
    Snacks.picker.man()
end, { desc = "Snacks: Man Pages" })

vim.keymap.set("n", "<leader>sm", function()
    Snacks.picker.marks()
end, { desc = "Snacks: Marks" })

vim.keymap.set("n", "<leader>sR", function()
    Snacks.picker.resume()
end, { desc = "Snacks: Resume" })

vim.keymap.set("n", "<leader>sq", function()
    Snacks.picker.qflist()
end, { desc = "Snacks: Quickfix List" })

vim.keymap.set("n", "<leader>uC", function()
    Snacks.picker.colorschemes()
end, { desc = "Snacks: Colorschemes" })

vim.keymap.set("n", "<leader>qp", function()
    Snacks.picker.projects()
end, { desc = "Snacks: Projects" })

vim.keymap.set("n", "gd", function()
    Snacks.picker.lsp_definitions()
end, { desc = "Snacks: Goto Definition" })

vim.keymap.set("n", "gr", function()
    Snacks.picker.lsp_references()
end, { nowait = true, desc = "Snacks: LSP References" })

vim.keymap.set("n", "gI", function()
    Snacks.picker.lsp_implementations()
end, { desc = "Snacks: LSP Goto Implementation" })

vim.keymap.set("n", "gy", function()
    Snacks.picker.lsp_type_definitions()
end, { desc = "Snacks: LSP Goto Type Definition" })

vim.keymap.set("n", "<leader>ss", function()
    Snacks.picker.lsp_symbols()
end, { desc = "Snacks: LSP Symbols" })

vim.keymap.set("n", "<leader>lgo", function()
    Snacks.lazygit.open()
end, { desc = "Snacks: LazyGit Open" })

vim.keymap.set("n", "<leader>lgl", function()
    Snacks.lazygit.log()
end, { desc = "Snacks: LazyGit Log" })

vim.keymap.set("n", "<leader>lgf", function()
    Snacks.lazygit.log_file()
end, { desc = "Snacks: LazyGit Log File" })

---@type snacks.plugins.Config
local opts = {
    image = {},
    lazygit = {},
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
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
        },
        sections = {
            { section = "header" },
            -- { section = "startup" },
            -- function()
            --     local lazy_stats = require("lazy.stats").stats()
            --     local ms = (math.floor(lazy_stats.startuptime * 100 + 0.5) / 100)
            --     return {
            --         align = "center",
            --         text = {
            --             { "loaded ", hl = "footer" },
            --             { lazy_stats.loaded .. "/" .. lazy_stats.count, hl = "special" },
            --             { " plugins in ", hl = "footer" },
            --             { ms .. "ms", hl = "special" },
            --         },
            --     }
            -- end,
        },
    },
    picker = {
        ui_select = true,
        exclude = {
            "mnt",
        },
        layout = {
            ---@diagnostic disable-next-line assign-type-mismatch
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
            -- the bonuses below, possibly require string concatenation and path normalization,
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
}

require("snacks").setup(opts)
