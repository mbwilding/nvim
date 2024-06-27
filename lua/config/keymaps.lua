-- Map ; to :
vim.keymap.set("n", ";", ":")

-- Disable arrow navigation
vim.keymap.set("n", "<Up>", "<Nop>")
vim.keymap.set("n", "<Down>", "<Nop>")
vim.keymap.set("n", "<Left>", "<Nop>")
vim.keymap.set("n", "<Right>", "<Nop>")

-- Allow hjkl navigation in non-normal mode
vim.keymap.set({ "i", "c" }, "<C-k>", "<Up>")
vim.keymap.set({ "i", "c" }, "<C-j>", "<Down>")
vim.keymap.set({ "i", "c" }, "<C-h>", "<Left>")
vim.keymap.set({ "i", "c" }, "<C-l>", "<Right>")

-- Window resize via Alt + hjkl
vim.keymap.set("n", "<A-j>", "<cmd>horizontal resize +1<CR>")
vim.keymap.set("n", "<A-k>", "<cmd>horizontal resize -1<CR>")
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -1<CR>")
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +1<CR>")
vim.keymap.set("n", "<A-J>", "<cmd>horizontal resize +5<CR>")
vim.keymap.set("n", "<A-K>", "<cmd>horizontal resize -5<CR>")
vim.keymap.set("n", "<A-H>", "<cmd>vertical resize -5<CR>")
vim.keymap.set("n", "<A-L>", "<cmd>vertical resize +5<CR>")

-- Window focus
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Window split
vim.keymap.set("n", "<C-s>", "<CMD>split<CR>")
vim.keymap.set("n", "<C-v>", "<CMD>vsplit<CR>")

-- Tab close
vim.keymap.set("n", "q", ":tabclose<CR>")

-- End search highlight and clear messages
vim.keymap.set("n", "<Esc>", "<CMD>noh<CR><CMD>echo<CR><Esc>")

-- Space do nothing
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Toggles
vim.keymap.set("n", "<leader>ir", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })

vim.keymap.set("n", "<leader>iw", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle Word Wrap" })

-- Redo
vim.api.nvim_set_keymap("n", "U", "<C-r>", { desc = "Redo" })

-- Clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>yy", '"+Y', { desc = "Copy to clipboard (line)" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>P", '"+P', { desc = "Paste from clipboard (before)" })

-- Registers
vim.keymap.set("n", "x", '"_x')

-- Debug
vim.keymap.set("n", "\\m", "<cmd>messages<CR>", { desc = "Debug: Messages" })
vim.keymap.set("n", "\\i", "<cmd>Inspect<CR>", { desc = "Highlights: Inspect" })

-- Sort
vim.keymap.set("v", "s", ":sort<CR>gv")

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })
