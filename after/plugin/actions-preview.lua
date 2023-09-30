require('actions-preview').setup {

}

vim.keymap.set({ 'n', 'v' }, '<leader>ap', require('actions-preview').code_actions)
