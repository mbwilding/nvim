local modules = {}

local files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins", "*.lua", false, true)

for _, file in ipairs(files) do
    local name = file:match("([^/]+)%.lua$")
    if name then
        table.insert(modules, name)
    end
end

for _, module in ipairs(modules) do
    require("plugins/" .. module)
end
