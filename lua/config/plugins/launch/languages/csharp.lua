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
    restore = "dotnet restore",
    build = "dotnet build --no-restore",
    run = "dotnet run --no-restore --no-build --project",
}

return M
