return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        integrations = {
            cmp = false,
            coq = false,
        },
        library = {
            {
                path = "${3rd}/luv/library",
                words = { "vim%.uv" },
            },
        },
    },
}
