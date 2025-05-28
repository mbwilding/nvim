local k = vim.keymap.set

-- Map ; to :
k("n", ";", ":")

-- Allow hjkl navigation in non-normal mode
k({ "i", "c" }, "<C-k>", "<Up>")
k({ "i", "c" }, "<C-j>", "<Down>")
k({ "i", "c" }, "<C-h>", "<Left>")
k({ "i", "c" }, "<C-l>", "<Right>")

-- Window focus
k("n", "<C-h>", "<C-w>h")
k("n", "<C-j>", "<C-w>j")
k("n", "<C-k>", "<C-w>k")
k("n", "<C-l>", "<C-w>l")

-- Clipboard
-- Check autocmds
-- k({ "n", "v" }, "<leader>y", "\"+y", { desc = "Copy to clipboard" })
-- k({ "n", "v" }, "<leader>yy", "\"+Y", { desc = "Copy to clipboard (line)" })
k({ "n", "v" }, "<leader>p", "\"+p", { desc = "Paste from clipboard" })
k({ "n", "v" }, "<leader>P", "\"+P", { desc = "Paste from clipboard (before)" })

-- Tab close
k("n", "q", ":tabclose<CR>")

-- End search highlight and clear messages
k("n", "<Esc>", "<CMD>noh<CR>")

-- Leader NOP
k({ "n", "v" }, "<leader>", "<Nop>")

-- Remap for dealing with word wrap
k("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
k("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Toggles
k("n", "<leader>ir", function()
    vim.o.relativenumber = not vim.o.relativenumber
    vim.notify("Relative Numbers: " .. tostring(vim.o.relativenumber))
end, { desc = "Toggle relative/absolute line numbers" })

k("n", "<leader>iw", function()
    vim.wo.wrap = not vim.wo.wrap
    vim.notify("Wrap: " .. tostring(vim.wo.wrap))
end, { desc = "Toggle Word Wrap" })

-- Redo
k("n", "U", "<C-r>", { desc = "Redo" })

-- Registers
k("n", "x", "\"_x")

-- Sort
k("v", "s", ":sort<CR>gv")

-- Select all
k("n", "<C-A>", "ggVG", { desc = "Select all" })

-- Mouse
k("v", "<RightMouse>", "\"+y")
k({ "n", "v" }, "<MiddleMouse>", "\"+p")

-- Rulers
local columns = "80,120"
k("n", "<leader>ic", function()
    if vim.o.colorcolumn == columns then
        vim.o.colorcolumn = ""
    else
        vim.o.colorcolumn = columns
    end
    local boundaries = vim.o.colorcolumn ~= "" and vim.o.colorcolumn or "disabled"
    vim.notify("Boundaries: " .. boundaries)
end, { desc = "Toggle Columns" })

-- HTML Generation
k("n", "<leader>ht", function()
    vim.cmd("TOhtml")
    vim.defer_fn(function()
        vim.lsp.buf.format({ async = false })
    end, 200)
end, { desc = "HTML" })
k("v", "<leader>ht", function()
    vim.cmd("'<,'>TOhtml")
    vim.defer_fn(function()
        vim.lsp.buf.format({ async = false })
    end, 200)
end, { desc = "HTML" })

-- Debug
-- k("n", "\\m", "<CMD>messages<CR>", { desc = "Debug: Messages" })
k("n", "\\i", "<CMD>Inspect<CR>", { desc = "Highlights: Inspect" })

-- Custom
k("n", "yd", function()
    local buf = vim.api.nvim_get_current_buf()
    local win = 0
    local cursor = vim.api.nvim_win_get_cursor(win)
    local line_num = cursor[1]
    local col = cursor[2]
    local line = vim.api.nvim_buf_get_lines(buf, line_num - 1, line_num, false)[1]
    vim.api.nvim_buf_set_lines(buf, line_num, line_num, false, { line })
    vim.api.nvim_win_set_cursor(win, { line_num + 1, col })
end, { desc = "Duplicate line" })

-- Whitespace
local whitespace = false
k("n", "<leader>iW", function()
    whitespace = not whitespace
    vim.opt.list = whitespace
end, { desc = "Toggle Whitespace Visuals" })

-- Diagnostic keymaps
k("n", "[d", function()
    vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Diagnostics: Goto previous diagnostic message" })
k("n", "]d", function()
    vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Diagnostics: Goto next diagnostic message" })

k("n", "<leader>id", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled(), {})
    vim.notify("Diagnostics: " .. tostring(vim.diagnostic.is_enabled()))
end, { desc = "Diagnostics: Toggle" })

k("n", "<leader>k", function()
    vim.diagnostic.open_float(nil, { scope = "line" })
end, { desc = "Diagnostics: View float" })

k("n", "<leader>ivt", function()
    vim.diagnostic.config({
        virtual_text = not vim.diagnostic.config().virtual_text,
    })
    vim.notify("Virtual Text: " .. tostring(vim.diagnostic.config().virtual_text))
end, { desc = "Diagnostics: Toggle Virtual Text" })

k("n", "<leader>ivl", function()
    vim.diagnostic.config({
        virtual_lines = not vim.diagnostic.config().virtual_lines,
    })
    vim.notify("Virtual Lines: " .. tostring(vim.diagnostic.config().virtual_lines))
end, { desc = "Diagnostics: Toggle Virtual Lines" })

local current_line = vim.diagnostic.config().virtual_lines.current_line
k("n", "<leader>ivc", function()
    current_line = not current_line
    vim.diagnostic.config({
        virtual_lines = {
            current_line = current_line,
        },
    })
    vim.notify("Virtual Lines Current Line: " .. tostring(vim.diagnostic.config().virtual_lines.current_line))
end, { desc = "Diagnostics: Toggle Virtual Lines Current Line" })
