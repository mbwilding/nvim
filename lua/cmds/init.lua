local modules = {
    "inspect",
    "json_convert",
    "push",
}

for _, module in ipairs(modules) do
    require("./cmds/" .. module)
end
