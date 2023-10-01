vim.loader.enable()
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

IsWindows = package.config:sub(1, 1) == "\\"

require("wilding")
