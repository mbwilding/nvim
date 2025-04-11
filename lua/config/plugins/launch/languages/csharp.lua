local M = {}

M.projects = require("config/plugins/launch/utils").find_projects({
    language = "csharp",
    pattern = "%.csproj$",
    get_name = function(path)
        local name = vim.fn.fnamemodify(path, ":t")
        return name:gsub("%.csproj$", "")
    end,
})

M.commands = {
    restore = { command = "dotnet restore", path = true },
    build = { command = "dotnet build --no-restore", path = true },
    run = { command = "dotnet run --no-restore --no-build --project", path = true },
}

return M
