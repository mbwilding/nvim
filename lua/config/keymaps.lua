-- Map ; to :
vim.keymap.set("n", ";", ":", { silent = true })

-- Lazy Package Manager
vim.keymap.set("n", "<leader>Tl", "<cmd>Lazy<CR>", { silent = true, desc = "Tool: Lazy" })

-- Window resize via Alt + arrows
vim.keymap.set("n", "<A-Up>", "<cmd>horizontal resize -1<CR>", { silent = true })
vim.keymap.set("n", "<A-Down>", "<cmd>horizontal resize +1<CR>", { silent = true })
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -1<CR>", { silent = true })
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +1<CR>", { silent = true })

-- Tab close
vim.keymap.set("n", "q", ":tabclose<CR>", { silent = true })

-- Disables search highlight
vim.keymap.set("n", "<CR>", ":noh<CR>", { silent = true })
vim.keymap.set("n", "<ESC>", ":noh<ESC>", { silent = true })

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

-- Buffer focus
vim.keymap.set("n", "<S-Left>", "<C-w>h", { silent = true })
vim.keymap.set("n", "<S-Down>", "<C-w>j", { silent = true })
vim.keymap.set("n", "<S-Up>", "<C-w>k", { silent = true })
vim.keymap.set("n", "<S-Right>", "<C-w>l", { silent = true })
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Toggles
vim.keymap.set("n", "<leader>ir", function()
	vim.wo.relativenumber = not vim.wo.relativenumber
end, { silent = true, desc = "Toggle relative line numbers" })

-- Debug
vim.keymap.set("n", "\\", "<cmd>Inspect<CR>", { silent = true, desc = "Theme: Inspect" })
