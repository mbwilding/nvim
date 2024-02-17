-- Disables search highlight
vim.keymap.set('n', '<CR>', ':noh<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<ESC>', ':noh<ESC>', { noremap = true, silent = true })

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Buffer focus
vim.keymap.set('n', '<S-Left>', '<C-w>h', {noremap = true, silent = true})
vim.keymap.set('n', '<S-Down>', '<C-w>j', {noremap = true, silent = true})
vim.keymap.set('n', '<S-Up>', '<C-w>k', {noremap = true, silent = true})
vim.keymap.set('n', '<S-Right>', '<C-w>l', {noremap = true, silent = true})

