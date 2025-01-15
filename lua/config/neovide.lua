if vim.g.neovide then
    local font = "NeoSpleen Nerd Font"

    local font_suffix = font .. ":h"

    if vim.fn.has("mac") == 1 then
        vim.o.guifont = font_suffix .. "20"
        vim.g.neovide_refresh_rate = 60
    else
        vim.o.guifont = font_suffix .. "17" -- :w-1
        vim.g.neovide_refresh_rate = 120
    end

    vim.g.neovide_position_animation_length = 0.1
    vim.g.neovide_scroll_animation_length = 0.1

    vim.g.neovide_cursor_animation_length = 0.04
    vim.g.neovide_cursor_trail_size = 0.2
    vim.g.neovide_cursor_vfx_mode = "" -- railgun, torpedo, pixiedust, sonicboom, ripple, wireframe

    vim.g.neovide_padding_top = 0
    vim.g.neovide_padding_bottom = 0
    vim.g.neovide_padding_right = 0
    vim.g.neovide_padding_left = 0

    vim.keymap.set("n", "<F11>", function()
        vim.g.neovide_fullscreen = not vim.g.neovide_fullscreen
    end)
end
