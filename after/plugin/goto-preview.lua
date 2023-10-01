local goto_preview = require("goto-preview")

goto_preview.setup()

vim.api.nvim_set_keymap("n", "<leader>pd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", { noremap = true, silent = true, desc = "Preview Definition" })
vim.api.nvim_set_keymap("n", "<leader>pD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", { noremap = true, silent = true, desc = "Preview Declaration" })
vim.api.nvim_set_keymap("n", "<leader>pt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", { noremap = true, silent = true, desc = "Preview Type Definition" })
vim.api.nvim_set_keymap("n", "<leader>pi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", { noremap = true, silent = true, desc = "Preview Implementation" })
vim.api.nvim_set_keymap("n", "<leader>pr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", { noremap = true, silent = true, desc = "Preview References" })
vim.api.nvim_set_keymap("n", "<leader>pc", "<cmd>lua require('goto-preview').close_all_win()<CR>", { noremap = true, silent = true, desc = "Close Previews" })
