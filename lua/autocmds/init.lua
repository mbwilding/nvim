local modules = {
    "close_with_q",
    "comment_vhs",
    "create_dir",
    "cursor_restore",
    "line_endings",
    "reload_file",
    "resize_splits",
    "wrap_spell",
    "yank_highlight",
}

for _, module in ipairs(modules) do
    require("./autocmds/" .. module)
end
