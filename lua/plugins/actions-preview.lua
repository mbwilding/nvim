return {
    "aznhe21/actions-preview.nvim",
    keys = {
        {
            "<leader><enter>",
            function()
                require("actions-preview").code_actions()
            end,
            desc = "Actions Preview",
            mode = { "n", "v" },
        },
    },
    opts = {},
}
