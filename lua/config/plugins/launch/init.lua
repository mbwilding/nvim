local utils = require("config/plugins/launch/utils")

vim.keymap.set("n", "<leader>0", function()
    utils.select_project(utils.merge())
end)
