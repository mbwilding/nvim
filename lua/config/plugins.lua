local priority = { "gronk", "lint", "heirline", "snacks" }

local modules = {}

local files = vim.fn.globpath(vim.fn.stdpath("config") .. "/lua/plugins", "*.lua", false, true)

for _, file in ipairs(files) do
    local name = file:match("([^/]+)%.lua$")
    if name then
        table.insert(modules, name)
    end
end

local priority_set = {}
for _, p in ipairs(priority) do
    priority_set[p] = true
end

local ordered = {}
for _, p in ipairs(priority) do
    if vim.tbl_contains(modules, p) then
        table.insert(ordered, p)
    end
end

for _, m in ipairs(modules) do
    if not priority_set[m] then
        table.insert(ordered, m)
    end
end

for _, module in ipairs(ordered) do
    require("plugins." .. module)
end
