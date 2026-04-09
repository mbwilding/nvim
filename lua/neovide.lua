if vim.g.neovide then
    local font = "NeoSpleen Nerd Font"

    local font_suffix = font .. ":h"

    if vim.fn.has("mac") == 1 then
        vim.o.guifont = font_suffix .. "18"
        vim.g.neovide_refresh_rate = 60
    elseif vim.fn.hostname() == "nona" then
        vim.o.guifont = font_suffix .. "21"
        vim.g.neovide_refresh_rate = 90
    else
        vim.o.guifont = font_suffix .. "26" -- :w-1
        vim.g.neovide_refresh_rate = 120
    end

    vim.g.neovide_opacity = 0.85
    vim.g.neovide_background_color = "#000000"

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

    vim.g.terminal_color_0 = "#181818"
    vim.g.terminal_color_1 = "#e78284"
    vim.g.terminal_color_2 = "#39cc8f"
    vim.g.terminal_color_3 = "#c9a26d"
    vim.g.terminal_color_4 = "#8caaee"
    vim.g.terminal_color_5 = "#f4b8e4"
    vim.g.terminal_color_6 = "#81c8be"
    vim.g.terminal_color_7 = "#a5adce"
    vim.g.terminal_color_8 = "#4f5258"
    vim.g.terminal_color_9 = "#ff4747"
    vim.g.terminal_color_10 = "#39cc8f"
    vim.g.terminal_color_11 = "#ffffff"
    vim.g.terminal_color_12 = "#9591ff"
    vim.g.terminal_color_13 = "#ed94c0"
    vim.g.terminal_color_14 = "#5abfb5"
    vim.g.terminal_color_15 = "#b5bfe2"
end
