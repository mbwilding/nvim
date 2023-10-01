local scrollbar = require("scrollbar")
local search = require("scrollbar.handlers.search")
local git = require("scrollbar.handlers.gitsigns")

scrollbar.setup()
search.setup()
git.setup()
