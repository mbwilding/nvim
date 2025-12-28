local modules = {
    "settings",
    "signs",
    "keymaps",
    "autocmds",
    "cmds",
    "platform",
    "neovide",
    "lazy",
}

for _, module in ipairs(modules) do
    require("config/" .. module)
end
