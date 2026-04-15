-- Discord Presence

---@type zpack.Spec
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
            flavor = "dark",
            swap_icons = false,
        },
    },
}
