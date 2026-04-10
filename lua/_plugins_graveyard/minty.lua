return {
    "nvchad/minty",
    lazy = true,
    keys = {
        {
            "<leader>mih",
            function()
                require("minty.huefy").open()
            end,
            desc = "Minty: Huefy",
            mode = "n",
        },
        {
            "<leader>mis",
            function()
                require("minty.shades").open()
            end,
            desc = "Minty: Shades",
            mode = "n",
        },
    },
    dependencies = {
        {
            "nvchad/volt",
            lazy = true,
        },
    },
}
