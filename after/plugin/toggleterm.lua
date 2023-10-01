local toggle_term = require("toggleterm")

local shell_command
if IsWindows then
    shell_command = "pwsh.exe -NoLogo"
else
    shell_command = nil
end

toggle_term.setup {
    -- open_mapping = [[<c-\>]],
    start_in_insert = true,
    terminal_mappings = true,
    -- direction = "float",
    shell = shell_command,
    auto_scroll = true,
    -- persist_mode = true,
    persist_size = true,
    close_on_exit = true,
}

vim.keymap.set({ "n", "t" }, "<M-1>", "<cmd>:2ToggleTerm direction=horizontal size=20<CR>")
vim.keymap.set({ "n", "t" }, "<M-2>", "<cmd>:3ToggleTerm direction=vertical size=100<CR>")
vim.keymap.set({ "n", "t" }, "<M-3>", "<cmd>:4ToggleTerm direction=float<CR>")
vim.keymap.set({ "n", "t" }, "<leader>gl", "<cmd>lua _lazygit_toggle()<CR>")
