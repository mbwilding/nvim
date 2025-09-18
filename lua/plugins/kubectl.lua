return {
    {
        "ramilito/kubectl.nvim",
        version = "2.*",
        build = "make build_go && cargo build --release --features kube/socks5",
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
            auto_refresh = 500, -- ms
            terminal_cmd = "ghostty -e",
            logs = {
                prefix = true,
                timestamps = true,
                since = "5m",
            },
        },
    },
}
