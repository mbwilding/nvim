return {
    "nvimdev/dashboard-nvim",
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
                action = "SnacksPickerFindFiles ",
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
    config = function(_, opts)
        vim.api.nvim_create_user_command("SnacksPickerFindFiles", function(picker_opts)
            require("snacks").picker.files({
                cwd = picker_opts.args,
                hidden = true,
                follow = true,
            })
        end, { nargs = 1 })

        require("dashboard").setup(opts)
    end,
}
