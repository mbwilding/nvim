return {
    "ramilito/kubectl.nvim",
    lazy = true,
    enabled = vim.fn.has("win32") == 0,
    keys = {
        {
            "<leader>kc",
            function()
                require("kubectl").toggle()
            end,
            desc = "Kubectl",
        },
    },
    opts = {},
}
