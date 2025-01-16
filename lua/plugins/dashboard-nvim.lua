return {
    -- "nvimdev/dashboard-nvim",
    "mbwilding/dashboard-nvim",
    lazy = true,
    event = "VimEnter",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        theme = "hyper",
        letter_list = "uhetonasidpgyfcrlxbmwqvz",
        config = {
            disable_move = false,
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
            footer = {},
        },
    },
}
