-- Debug print line adding

-- g/p or g/P
-- g/v

return {
    "andrewferrier/debugprint.nvim",
    dependencies = {
        "echasnovski/mini.hipatterns",
    },
    opts = {
        highlight_lines = false,
        print_tag = "DEBUG",
        display_location = false,
        display_counter = true,
        display_snippet = false,
    },
}
