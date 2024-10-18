-- Markview shows a formatted version of markdown unless in insert mode.

return {
    "OXY2DEV/markview.nvim",
    lazy = true,
    event = "BufEnter",
    ft = "markdown",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local presets = require("markview.presets")

        require("markview").setup({
            block_quotes = {},
            callbacks = {},
            checkboxes = presets.checkboxes.nerd,
            code_blocks = {},
            escaped = {},
            footnotes = {},
            -- headings = presets.headings.arrowed,
            horizontal_rules = presets.horizontal_rules.thick,
            html = {},
            inline_codes = {},
            latex = {},
            links = {},
            list_items = {},
            tables = {}
        })
    end
}
