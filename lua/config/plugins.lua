
local function scan_plugin_files(dir)
    local uv = vim.loop
    local config_path = vim.fn.stdpath("config") .. "/lua/plugins"
    local plugin_files = {}

    local req = uv.fs_scandir(dir)
    if not req then
        return
    end
    while true do
        local name, type = uv.fs_scandir_next(req)
        if not name then
            break
        end
        local full_path = dir .. "/" .. name
        if type == "directory" then
            scan_plugin_files(full_path)
        elseif type == "file" and name:sub(-4) == ".lua" then
            table.insert(plugin_files, full_path)
        end
    end

    return plugin_files
end

local plugin_files = scan_plugin_files(config_path)

local function path_to_module(path)
    local rel = path:sub(#vim.fn.stdpath("config") + 6, -5)
    rel = rel:gsub("[/\\]", ".")
    return rel
end

local plugins = {}
for _, path in ipairs(plugin_files) do
    local module = path_to_module(path)
    local ok, result = pcall(require, module)
    if ok then
        table.insert(plugins, result)
    else
        vim.notify("Failed to require module: " .. module .. " (" .. result .. ")", vim.log.levels.WARN)
    end
end

local function process_plugin(plugin)
    local dependencies = plugin.dependencies
    if dependencies then
        for _, dependency in ipairs(dependencies) do
            if type(dependency) == "string" then
                local url
                if not dependency:match("^https://") then
                    url = "https://github.com/" .. dependency
                else
                    url = dependency
                end
                vim.pack.add({
                    url,
                }, { confirm = false })
            elseif type(dependency) == "table" then
                process_plugin(plugin)
            end
        end
    end
end

for _, plugin in ipairs(plugins) do
    process_plugin(plugin)
end

-- vim.pack.add({
--     "https://github.com/user/plugin1",
--     { src = "https://github.com/user/plugin1" },
--     { src = "https://github.com/user/generic-name", name = "plugin2" },
--     {
--         src = "https://github.com/user/plugin3",
--         version = vim.version.range("1.0"),
--     },
--     {
--         src = "https://github.com/user/plugin4",
--         version = "main",
--     },
-- })
