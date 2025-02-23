local empty = '   '

return {
    "codethread/qmk.nvim",
    cmd = { "QMKFormat" },
    opts = {
        name = "LAYOUT_voyager",
        variant = "qmk",
        comment_preview = {
            position = "top",
            keymap_overrides = (function()
                -- Standalone
                local keys = {
                    KC_NO = empty,
                    KC_TRANSPARENT = empty,
                    MI_ON = "MIDI ON",
                    MI_OFF = "MIDI OFF",
                    MI_OCTD = "OCTAVE ",
                    MI_OCTU = "OCTAVE ",
                    MI_TRSD = "TRANSPOSE ",
                    MI_TRSU = "TRANSPOSE ",
                    MI_TOGG = "MIDI TOGGLE",
                    KC_DOWN = "",
                    KC_UP = "",
                    KC_LEFT = "",
                    KC_RIGHT = "",
                }

                -- F Keys
                for i = 1, 12 do
                    local key = "KC_F" .. i
                    keys[key] = "F" .. i
                end

                -- MIDI
                local note_names = {
                    { "C" },
                    { "Cs", "Db" },
                    { "D" },
                    { "Ds", "Eb" },
                    { "E" },
                    { "F" },
                    { "Fs", "Gb" },
                    { "G" },
                    { "Gs", "Ab" },
                    { "A" },
                    { "As", "Bb" },
                    { "B" },
                }

                for octave = 0, 5 do
                    for _, names in ipairs(note_names) do
                        for _, note_letter in ipairs(names) do
                            local octave_str = octave == 0 and "" or tostring(octave)
                            local key = "MI_" .. note_letter .. octave_str
                            local display_note_letter = note_letter:gsub('s', '#')
                            keys[key] = display_note_letter .. octave_str
                        end
                    end
                end

                return keys
            end)()
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
