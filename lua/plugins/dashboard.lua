return {
    -- "nvimdev/dashboard-nvim",
    "mbwilding/dashboard-nvim",
    event = "VimEnter",
    lazy = true,
    opts = {
        theme = "hyper",
        letter_list = "uhetonasidpgyfcrlxbmwqvz",
        config = {
            disable_move = true,
            week_header = {
                enable = true,
            },
            shortcut = {
                {
                    icon = " ",
                    desc = "New",
                    icon_hl = "OilFile",
                    group = "@property",
                    action = "enew",
                    key = "e",
                },
                {
                    icon = " ",
                    desc = "Content",
                    icon_hl = "Directory",
                    group = "Label",
                    action = "Telescope live_grep",
                    key = "g",
                },
                {
                    icon = " ",
                    desc = "Files",
                    icon_hl = "Directory",
                    group = "Label",
                    action = "Telescope find_files",
                    key = "f",
                },
                -- { desc = "󰊳 Lazy Update", group = "@property", action = "Lazy update", key = "l" },
                -- { desc = "󰊳 Mason Update", group = "@property", action = "MasonUpdate", key = "m" },
            },
            project = {
                enable = true,
                limit = 8,
                icon = "  ",
                label = "Projects",
                action = "Telescope find_files cwd=",
            },
            mru = {
                limit = 8,
                icon = "  ",
                label = "Recent",
                cwd_only = true,
            },
            footer = {}
        },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
}
