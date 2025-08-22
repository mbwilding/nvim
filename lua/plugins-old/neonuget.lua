return {
    "MonsieurTib/neonuget",
    lazy = true,
    keys = {
        {
            "<leader>ng",
            "<CMD>NuGet<CR>",
            desc = "NeoNuget",
        },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    opts = {},
}
