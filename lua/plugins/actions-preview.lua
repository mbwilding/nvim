return {
    "aznhe21/actions-preview.nvim",
    opts = {},
    keys = {
        {
            "<leader><enter>",
            function()
                require("actions-preview").code_actions()
            end,
            desc = "Actions Preview",
            mode = { "v", "n" },
        },
    },
}
