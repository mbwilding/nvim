vim.g.start_time = vim.uv.hrtime()

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.g.end_time = vim.uv.hrtime()
    end,
})

local base = vim.fn.stdpath("config") .. "/lua/"

local function autoload(dir)
    local path = dir and base .. dir or base
    local files = vim.fn.readdir(path)
    for _, name in ipairs(files) do
        if not name:match("^_") and name ~= "plugins" then
            if vim.fn.isdirectory(path .. "/" .. name) == 1 then
                autoload(dir and (dir .. "/" .. name) or name)
            else
                local mod = name:match("^(.+)%.lua$")
                if mod then
                    local req = dir and (dir:gsub("/", ".") .. "." .. mod) or ("./" .. mod)
                    require(req)
                end
            end
        end
    end
end

autoload(nil)
