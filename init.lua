for _, f in ipairs(vim.fn.glob("./lua/config/*.lua", false, true)) do
    require("config." .. f:match("([^/]+)%.lua$"))
end
