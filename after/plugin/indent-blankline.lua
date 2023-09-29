local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E39E9B" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E9D4A7" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#8FBAF1" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D7B389" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#AABE92" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#D0A2E1" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#7EC0C8" })
end)

require("ibl").setup { indent = { highlight = highlight } }