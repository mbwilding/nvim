return {
    "jake-stewart/multicursor.nvim",
    lazy = true,
    event = "BufEnter",
    -- branch = "1.0",
    keys = {
        { "<up>",          function() require("multicursor-nvim").addCursor("k") end,  mode = { "n", "v" } },
        { "<down>",        function() require("multicursor-nvim").addCursor("j") end,  mode = { "n", "v" } },
        { "<c-n>",         function() require("multicursor-nvim").addCursor("*") end,  mode = { "n", "v" } },
        { "<c-s>",         function() require("multicursor-nvim").skipCursor("*") end, mode = { "n", "v" } },
        { "<left>",        function() require("multicursor-nvim").nextCursor() end,    mode = { "n", "v" } },
        { "<right>",       function() require("multicursor-nvim").prevCursor() end,    mode = { "n", "v" } },
        { "<leader>x",     function() require("multicursor-nvim").deleteCursor() end,  mode = { "n", "v" } },
        { "<c-leftmouse>", function() require("multicursor-nvim").handleMouse() end,   mode = "n" },
        {
            "<c-q>",
            function()
                local mc = require("multicursor-nvim")
                if mc.cursorsEnabled() then
                    mc.disableCursors()
                else
                    mc.addCursor()
                end
            end,
            mode = { "n", "v" }
        },
        {
            "<ESC>",
            function()
                local mc = require("multicursor-nvim")
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    -- Default <esc> handler.
                end
            end,
            mode = "n"
        },
        { "<leader>a", function() require("multicursor-nvim").alignCursors() end,       mode = "n" },
        { "S",         function() require("multicursor-nvim").splitCursors() end,       mode = "v" },
        { "I",         function() require("multicursor-nvim").insertVisual() end,       mode = "v" },
        { "A",         function() require("multicursor-nvim").appendVisual() end,       mode = "v" },
        { "M",         function() require("multicursor-nvim").matchCursors() end,       mode = "v" },
        { "<leader>t", function() require("multicursor-nvim").transposeCursors(1) end,  mode = "v" },
        { "<leader>T", function() require("multicursor-nvim").transposeCursors(-1) end, mode = "v" },
    },
    config = function()
        require("multicursor-nvim").setup()

        -- Customize how cursors look.
        vim.api.nvim_set_hl(0, "MultiCursorCursor", { link = "Cursor" })
        vim.api.nvim_set_hl(0, "MultiCursorVisual", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
        vim.api.nvim_set_hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
    end,
}
