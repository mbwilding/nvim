return {
    "petertriho/nvim-scrollbar",
    dependencies = {
        "lewis6991/gitsigns.nvim",
        -- "kevinhwang91/nvim-hlslens",
    },
    opts = {
        hide_if_all_visible = true,
        throttle_ms = 50,
        handlers = {
            cursor = true,
            diagnostic = true,
            gitsigns = true,
            handle = true,
            search = false,
            ale = false,
        },
    },
}
