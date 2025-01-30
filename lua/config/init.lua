local modules = {
    "settings",
    "signs",
    "keymaps",
    "autocmds",
    "cmds",
    "filetypes",
    "platform",
    "neovide",
    "lazy",
    "plugins/notes",
    "plugins/launch",
}

for _, module in ipairs(modules) do
    require("config/" .. module)
end
