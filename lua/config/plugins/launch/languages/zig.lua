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
    build = { command = "zig build", path = false },
    run = { command = "zig build run", path = false },
    test = { command = "zig build test", path = false },
    watch = { command = "zig build --watch", path = false },
}

return M
