local config_files = vim.fn.glob("./lua/config/*.lua", false, true)
for _, file in ipairs(config_files) do
    require("config." .. file:match("([^/]+)%.lua$"))
end
