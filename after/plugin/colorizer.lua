local colorizer = require("colorizer")

colorizer.setup({
    "*",    -- Highlight all files, but customize some others
    "!vim", -- Exclude vim from highlighting
})
