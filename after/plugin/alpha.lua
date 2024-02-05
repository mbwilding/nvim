local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

local name = {
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[]],
    [[ /$$      /$$             /$$       /$$           /$$      /$$ /$$ /$$       /$$ /$$                    ]],
    [[| $$$    /$$$            | $$      | $$          | $$  /$ | $$|__/| $$      | $$|__/                    ]],
    [[| $$$$  /$$$$  /$$$$$$  /$$$$$$   /$$$$$$        | $$ /$$$| $$ /$$| $$  /$$$$$$$ /$$ /$$$$$$$   /$$$$$$ ]],
    [[| $$ $$/$$ $$ |____  $$|_  $$_/  |_  $$_/        | $$/$$ $$ $$| $$| $$ /$$__  $$| $$| $$__  $$ /$$__  $$]],
    [[| $$  $$$| $$  /$$$$$$$  | $$      | $$          | $$$$_  $$$$| $$| $$| $$  | $$| $$| $$  \ $$| $$  \ $$]],
    [[| $$\  $ | $$ /$$__  $$  | $$ /$$  | $$ /$$      | $$$/ \  $$$| $$| $$| $$  | $$| $$| $$  | $$| $$  | $$]],
    [[| $$ \/  | $$|  $$$$$$$  |  $$$$/  |  $$$$/      | $$/   \  $$| $$| $$|  $$$$$$$| $$| $$  | $$|  $$$$$$$]],
    [[|__/     |__/ \_______/   \___/     \___/        |__/     \__/|__/|__/ \_______/|__/|__/  |__/ \____  $$]],
    [[                                                                                               /$$  \ $$]],
    [[                                                                                              |  $$$$$$/]],
    [[                                                                                               \______/ ]],
}

dashboard.section.header.val = name

dashboard.section.buttons.val = {
    dashboard.button("n", " New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("f", " Find file", "<leader>sf"),
    dashboard.button("r", " Recently opened files", "<leader>so"),
    dashboard.button("p", " Recently opened projects", "<leader>sP"),
    dashboard.button("t", " Find text", "<leader>sg"),
    dashboard.button("q", " Quit", ":qa<CR>")
}

dashboard.section.footer.val = " Matt Wilding"

alpha.setup(dashboard.config)
