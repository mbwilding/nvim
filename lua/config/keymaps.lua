-- Map ; to :
vim.keymap.set("n", ";", ":")

-- Allow hjkl navigation in non-normal mode
vim.keymap.set({ "i", "c" }, "<C-k>", "<Up>")
vim.keymap.set({ "i", "c" }, "<C-j>", "<Down>")
vim.keymap.set({ "i", "c" }, "<C-h>", "<Left>")
vim.keymap.set({ "i", "c" }, "<C-l>", "<Right>")

-- Window focus
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Tab close
vim.keymap.set("n", "q", ":tabclose<CR>")

-- End search highlight and clear messages
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR>")

-- Leader NOP
vim.keymap.set({ "n", "v" }, "<leader>", "<Nop>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Toggles
vim.keymap.set("n", "<leader>ir", function()
    vim.o.relativenumber = not vim.o.relativenumber
    vim.notify("Relative Numbers: " .. tostring(vim.o.relativenumber))
end, { desc = "Toggle relative/absolute line numbers" })

vim.keymap.set("n", "<leader>iw", function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify("Wrap: " .. tostring(vim.wo.wrap), vim.log.levels.INFO)
end, { desc = "Toggle Word Wrap" })

-- Redo
vim.keymap.set("n", "U", "<C-r>", { desc = "Redo" })

-- Clipboard
-- Check autocmds
-- vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Copy to clipboard" })
-- vim.keymap.set({ "n", "v" }, "<leader>yy", "\"+Y", { desc = "Copy to clipboard (line)" })
vim.keymap.set({ "n", "v" }, "<leader>p", "\"+p", { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", "\"+P", { desc = "Paste from clipboard (before)" })

-- Registers
vim.keymap.set("n", "x", "\"_x")

-- Sort
vim.keymap.set("v", "s", ":sort<CR>gv")

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- Mouse
vim.keymap.set("v", "<RightMouse>", "\"+y")
vim.keymap.set({ "n", "v" }, "<MiddleMouse>", "\"+p")

-- Rulers
local columns = "80,120"
vim.keymap.set("n", "<leader>ic", function()
    if vim.o.colorcolumn == columns then
        vim.o.colorcolumn = ""
    else
        vim.o.colorcolumn = columns
    end
    local boundaries = vim.o.colorcolumn ~= "" and vim.o.colorcolumn or "disabled"
    vim.notify("Boundaries: " .. boundaries)
end, { desc = "Toggle Columns" })

-- HTML Generation
vim.keymap.set("n", "<leader>ht", function()
    vim.cmd("TOhtml")
    vim.defer_fn(function()
        vim.lsp.buf.format({ async = false })
    end, 200)
end, { desc = "HTML" })
vim.keymap.set("v", "<leader>ht", function()
    vim.cmd("'<,'>TOhtml")
    vim.defer_fn(function()
        vim.lsp.buf.format({ async = false })
    end, 200)
end, { desc = "HTML" })

-- Debug
-- vim.keymap.set("n", "\\m", "<CMD>messages<CR>", { desc = "Debug: Messages" })
vim.keymap.set("n", "\\i", "<CMD>Inspect<CR>", { desc = "Highlights: Inspect" })

-- Custom
vim.keymap.set("n", "yd", "yyp", { desc = "Duplicate line" })

-- Whitespace
local whitespace = false
vim.keymap.set("n", "<leader>iW", function()
    whitespace = not whitespace
    vim.opt.list = whitespace
end, { desc = "Toggle Whitespace Visuals" })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnostics: Goto previous diagnostic message" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnostics: Goto next diagnostic message" })

vim.keymap.set("n", "<leader>ivt", function()
    vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text,
    })
    vim.notify("Virtual Text: " .. tostring(vim.diagnostic.config().virtual_text))
end, { desc = "Diagnostics: Toggle Virtual Text" })

vim.keymap.set("n", "<leader>ivl", function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
    })
    vim.notify("Virtual Lines: " .. tostring(vim.diagnostic.config().virtual_lines))
end, { desc = "Diagnostics: Toggle Virtual Lines" })

vim.keymap.set("n", "<leader>id", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled(), {})
    vim.notify("Diagnostics: " .. tostring(vim.diagnostic.is_enabled()))
end, { desc = "Diagnostics: Toggle" })

vim.keymap.set("n", "<leader>k", function()
    vim.diagnostic.open_float(nil, { scope = "line" })
end, { desc = "Diagnostics: View float" })
