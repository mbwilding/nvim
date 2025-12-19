return {
    "ramilito/kubectl.nvim",
    version = "2.*",
    dependencies = "saghen/blink.download",
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
        terminal_cmd = "ghostty -e",
        logs = {
            prefix = true,
            timestamps = true,
            since = "5m",
        },
    },
}
