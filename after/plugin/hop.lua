local hop = require("hop")
local directions = require("hop.hint").HintDirection

-- Config Setup
hop.setup {
    keys = "aoeuidhtnsqjkxbmwvzpyfgcrl",
    case_insensitive = false
} -- Dvorak Key Mapping

-- Key Mapping
local keymap_options = { silent = true }
local function set_keymap(mode, keys, cmd, opts)
    vim.api.nvim_set_keymap(mode, keys, cmd, opts or keymap_options)
end

set_keymap("n", "s", ":HopChar2<cr>")
set_keymap("n", "S", ":HopWord<cr>")
vim.keymap.set("", "ls", ":HopLine<CR>", { desc = "Hop Line", silent = true })

-- Function Setup
local function hop_hint_char1_customized(args)
    hop.hint_char1(args)
end

-- Function Key Mapping
local function_keymap_options = { remap = true }
local function set_function_keymap(mode, keys, func, opts)
    vim.keymap.set(mode, keys, func, opts or function_keymap_options)
end

set_function_keymap("", "f", function()
    hop_hint_char1_customized({
        direction = directions.AFTER_CURSOR,
        current_line_only = true
    })
end)

set_function_keymap("", "F", function()
    hop_hint_char1_customized({
        direction = directions.BEFORE_CURSOR,
        current_line_only = true
    })
end)

set_function_keymap("", "t", function()
    hop_hint_char1_customized({
        direction = directions.AFTER_CURSOR,
        current_line_only = true,
        hint_offset = -1
    })
end)

set_function_keymap("", "T", function()
    hop_hint_char1_customized({
        direction = directions.BEFORE_CURSOR,
        current_line_only = true,
        hint_offset = 1
    })
end)
