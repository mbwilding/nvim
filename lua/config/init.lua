require("config.settings")
require("config.lazy")
require("config.keymaps")
require("config.autocmds")
require("config.cmds")
require("config.filetypes")
require("config.platform")

if vim.g.neovide then
    require("config.neovide")
end
