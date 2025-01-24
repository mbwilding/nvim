local configs = vim.fn.readdir(vim.fn.stdpath("config") .. "/lua/config")
for _, config in ipairs(configs) do
    require("config." .. config:match("([^/]+)%.lua$"))
end
