local actions_preview = require("actions-preview")

actions_preview.setup()

vim.keymap.set({ "n", "v" }, "<leader>ap", require("actions-preview").code_actions)
