local M = {}

M.projects = require("config/plugins/launch/utils").find_projects({
    language = "zig",
    pattern = "build.zig",
    get_name = function(path)
        local name = vim.fn.fnamemodify(path, ":t")
        local file = name:gsub("%.zig$", "")
        return file
    end,
})

M.commands = {
    run = { command = "zig build run", path = false },
    build = { command = "zig build", path = false },
    test = { command = "zig build test", path = false },
    watch = { command = "zig build --watch", path = false },
}

return M
