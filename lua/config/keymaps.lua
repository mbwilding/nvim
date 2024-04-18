-- Map ; to :
vim.keymap.set("n", ";", ":", { silent = true })

-- Disable arrow navigation
-- vim.keymap.set({ "n", "i", "c" }, "<Up>", "<Nop>", { silent = true })
-- vim.keymap.set({ "n", "i", "c" }, "<Down>", "<Nop>", { silent = true })
-- vim.keymap.set({ "n", "i", "c" }, "<Left>", "<Nop>", { silent = true })
-- vim.keymap.set({ "n", "i", "c" }, "<Right>", "<Nop>", { silent = true })

-- Allow hjkl navigation in non-normal mode
vim.keymap.set({ "i", "c" }, "<C-k>", "<Up>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-j>", "<Down>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-h>", "<Left>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-l>", "<Right>", { silent = true })

-- Window resize via Alt + hjkl
vim.keymap.set("n", "<A-k>", "<cmd>horizontal resize -1<CR>", { silent = true })
vim.keymap.set("n", "<A-j>", "<cmd>horizontal resize +1<CR>", { silent = true })
vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -1<CR>", { silent = true })
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +1<CR>", { silent = true })

-- Tab close
vim.keymap.set("n", "q", ":tabclose<CR>", { silent = true })

-- Disables search highlight
vim.keymap.set("n", "<CR>", "<cmd>noh<CR>", { silent = true })
vim.keymap.set("n", "<ESC>", "<cmd>noh<ESC>", { silent = true })

-- Space do nothing
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Window focus
vim.keymap.set("n", "H", "<C-w>h", { silent = true })
vim.keymap.set("n", "J", "<C-w>j", { silent = true })
vim.keymap.set("n", "K", "<C-w>k", { silent = true })
vim.keymap.set("n", "L", "<C-w>l", { silent = true })

-- Toggles
vim.keymap.set("n", "<leader>ir", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end, { silent = true, desc = "Toggle relative line numbers" })

vim.keymap.set('n', '<leader>iw', function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle Word Wrap" })

-- Debug
vim.keymap.set("n", "\\", "<cmd>Inspect<CR>", { silent = true, desc = "Theme: Inspect" })
