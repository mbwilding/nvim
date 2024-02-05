local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local highlight_colors = {
    RainbowRed    = "#E39E9B",
    RainbowYellow = "#E9D4A7",
    RainbowBlue   = "#8FBAF1",
    RainbowOrange = "#D7B389",
    RainbowGreen  = "#AABE92",
    RainbowViolet = "#D0A2E1",
    RainbowCyan   = "#7EC0C8",
}

local hooks = require "ibl.hooks"

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    for group_name, color in pairs(highlight_colors) do
        vim.api.nvim_set_hl(0, group_name, { fg = color })
    end
end)

require("ibl").setup {
    indent = {
        highlight = highlight
    }
}
