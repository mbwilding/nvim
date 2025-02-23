local empty = '   '

return {
    "mbwilding/qmk.nvim",
    cmd = { "QMKFormat" },
    dev = false,
    opts = {
        name = "LAYOUT_voyager",
        variant = "qmk",
        comment_preview = {
            position = "top",
            keymap_overrides = {
                KC_NO = empty,
                KC_TRANSPARENT = empty,
            }
        },
        layout = {
            "x x x x x x _ _ x x x x x x",
            "x x x x x x _ _ x x x x x x",
            "x x x x x x _ _ x x x x x x",
            "x x x x x x _ _ x x x x x x",
            "_ _ _ _ x x _ _ x x _ _ _ _",
        }
    }
}
