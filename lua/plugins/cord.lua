-- Discord Presence

return {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = {
        editor = {
            client = "neovim",
            tooltip = "Neovim btw",
        },
        display = {
            theme = "classic",
            flavor = "accent",
            swap_icons = false,
        },
    },
}
