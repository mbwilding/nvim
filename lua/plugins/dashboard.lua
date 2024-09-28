return {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = {
        theme = 'hyper',
        config = {
            week_header = {
                enable = true,
            },
            shortcut = {
                {
                    icon = ' ',
                    icon_hl = '@variable',
                    desc = 'Files',
                    group = 'Label',
                    action = 'Telescope find_files',
                    key = 'f',
                },
                {
                    icon = ' ',
                    icon_hl = '@variable',
                    desc = 'Content',
                    group = 'Label',
                    action = 'Telescope live_grep',
                    key = 'g',
                },
                { desc = '󰊳 Lazy Update', group = '@property', action = 'Lazy update', key = 'l' },
                { desc = '󰊳 Mason Update', group = '@property', action = 'MasonUpdate', key = 'm' },
            },
        },
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    }
}
