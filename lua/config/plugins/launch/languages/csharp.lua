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
    run = { command = "dotnet run --no-restore --no-build --project", path = true },
    build = { command = "dotnet build --no-restore", path = true },
    restore = { command = "dotnet restore", path = true },
    ["restore-all"] = { command = "dotnet restore", path = false },
    ["watch"] = { command = "dotnet watch", path = false },
    ["watch-non-interactive"] = { command = "dotnet watch --non-interactive", path = false },
}

return M
