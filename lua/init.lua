local function autoload(dir)
    local path = vim.fn.stdpath("config") .. "/lua/" .. (dir and dir .. "/" or "")
    for _, name in ipairs(vim.fn.readdir(path)) do
        local mod = name:match("^([^_].-)%.lua$")
        if mod and mod ~= "init" then
            require(dir and (dir .. "." .. mod) or ("./" .. mod))
        end
    end
end

require("settings")
autoload("autocmds")
autoload("cmds")
autoload(nil)
