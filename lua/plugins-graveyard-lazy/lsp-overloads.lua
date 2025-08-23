return {
    "Issafalcon/lsp-overloads.nvim",
    ---@type LspOverloadsSettings
    ---@diagnostic disable-next-line: missing-fields
    opts = {
        ui = {
            -- The border to use for the signature popup window. Accepts same border values as |nvim_open_win()|.
            border = "single",
            height = nil,
            width = nil,
            wrap = true,
            wrap_at = nil,
            max_width = nil,
            max_height = nil,
            close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
            focusable = true,
            focus = false,
            offset_x = 0,
            offset_y = 0,
            silent = true,
            floating_window_above_cur_line = false,
        },
        keymaps = {
            next_signature = "<C-j>",
            previous_signature = "<C-k>",
            next_parameter = "<C-l>",
            previous_parameter = "<C-h>",
            close_signature = "<A-s>",
        },
        display_automatically = true,
        silent = false,
    },
}
