return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {
            style = "night",
            transparent = true,
            styles = {
                comments = { italic = true },
                keywords = { italic = false },
                functions = { italic = false },
                variables = { italic = false },
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "transparent", -- style for sidebars, see below
                floats = "dark", -- style for floating windows
            },
        },
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
}
