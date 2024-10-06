-- Markview shows a formatted version of markdown unless in insert mode.

return {
    "OXY2DEV/markview.nvim",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    opts = {
        block_quotes = {},
        callbacks = {},
        checkboxes = require("markview.presets").checkboxes.nerd,
        code_blocks = {},
        escaped = {},
        footnotes = {},
        -- headings = require("markview.presets").headings.arrowed,
        horizontal_rules = require("markview.presets").horizontal_rules.thick,
        html = {},
        inline_codes = {},
        latex = {},
        links = {},
        list_items = {},
        tables = {}
    },
}
