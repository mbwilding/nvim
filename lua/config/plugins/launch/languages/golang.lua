local M = {}

M.projects = require("config/plugins/launch/utils").find_projects({
    language = "csharp",
    pattern = "%.mod$",
    get_name = function(path)
        return vim.fn.fnamemodify(path, ":p:h:t")
    end,
})

-- TODO
M.commands = {
    -- restore = "",
    -- build = "",
    -- run = "",
}

return M
