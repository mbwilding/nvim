local ignore = { plugins = true }

local function autoload(dir)
    local base = vim.fn.stdpath("config") .. "/lua/"
    local path = dir and base .. dir or base
    for _, name in ipairs(vim.fn.readdir(path)) do
        if vim.fn.isdirectory(path .. "/" .. name) == 1 then
            if not ignore[name] and not name:match("^_") then
                autoload(dir and (dir .. "/" .. name) or name)
            end
        else
            local mod = name:match("^([^_].-)%.lua$")
            if mod and mod ~= "init" then
                local req = dir and (dir:gsub("/", ".") .. "." .. mod) or ("./" .. mod)
                require(req)
            end
        end
    end
end

require("settings")
autoload()
