-- Debug printing

---@type zpack.Spec
return {
    "andrewferrier/debugprint.nvim",
    dependencies = {
        "nvim-mini/mini.hipatterns",
        branch = "main",
    },
    opts = {
        highlight_lines = false,
        print_tag = "DEBUGPRINT",
        display_location = false,
        display_counter = true,
        display_snippet = false,
        keymaps = {
            normal = {
                plain_below = "g?p",
                plain_above = "g?P",
                variable_below = "g?v",
                variable_above = "g?V",
                variable_below_alwaysprompt = false,
                variable_above_alwaysprompt = false,
                surround_plain = "g?sp",
                surround_variable = "g?sv",
                surround_variable_alwaysprompt = false,
                textobj_below = "g?o",
                textobj_above = "g?O",
                textobj_surround = "g?so",
                toggle_comment_debug_prints = false,
                delete_debug_prints = false,
            },
            insert = {
                plain = "<C-G>p",
                variable = "<C-G>v",
            },
            visual = {
                variable_below = "g?v",
                variable_above = "g?V",
            },
        },
    },
}
