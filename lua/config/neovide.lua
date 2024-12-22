local font = "NeoSpleen Nerd Font:h"

if vim.fn.has("mac") == 1 then
    vim.o.guifont = font .. "20"
    vim.g.neovide_refresh_rate = 60
else
    vim.o.guifont = font .. "17" -- :w-1
    vim.g.neovide_refresh_rate = 120
end

vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_cursor_trail_size = 0.1
vim.g.neovide_cursor_vfx_mode = "" -- railgun, torpedo, pixiedust, sonicboom, ripple, wireframe

vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

