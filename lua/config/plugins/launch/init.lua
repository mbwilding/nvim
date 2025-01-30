-- TODO
-- Search all files (rg?) and from file extensions, do patterns, rather than defining patterns that search all files anyway

local utils = require("config/plugins/launch/utils")

vim.keymap.set("n", "<leader>0", function()
    utils.select_project(utils.merge())
end)
