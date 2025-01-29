return {
    -- "ramilito/kubectl.nvim",
    "mbwilding/kubectl.nvim",
    dev = true,
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
    opts = {
        terminal_cmd = "ghostty -e"
    },
}
