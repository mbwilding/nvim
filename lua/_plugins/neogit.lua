return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "folke/snacks.nvim",
        -- "sindrets/diffview.nvim",
    },
    lazy = true,
    cmd = "Neogit",
    keys = {
        {
            "<leader>gg",
            "<CMD>Neogit<CR>",
            desc = "Neogit: Toggle",
        },
    },
}
