local base = vim.fn.stdpath("config") .. "/lua/"

local function autoload(dir)
    local path = dir and base .. dir or base
    local files = vim.fn.readdir(path)
    for _, name in ipairs(files) do
        if vim.fn.isdirectory(path .. "/" .. name) == 1 then
            if not name:match("^_") then
                autoload(dir and (dir .. "/" .. name) or name)
            end
        else
            local mod = name:match("^([^_].+)%.lua$")
            if mod then
                local req = dir and (dir:gsub("/", ".") .. "." .. mod) or ("./" .. mod)
                require(req)
            end
        end
    end
end

autoload(nil)
