local modules = {
    "settings",
    "signs",
    "keymaps",
    "platform",
    "neovide",
    "lazy",
}

for _, module in ipairs(modules) do
    require("./" .. module)
end

local function autoload(dir)
    local path = vim.fn.stdpath("config") .. "/lua/" .. dir
    for _, name in ipairs(vim.fn.readdir(path)) do
        local mod = name:match("^([^_].-)%.lua$")
        if mod then
            require(dir .. "." .. mod)
        end
    end
end

autoload("autocmds")
autoload("cmds")
