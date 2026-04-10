return {
    "nvim-pack/nvim-spectre",
    lazy = true,
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        {
            "<leader>sr",
            function()
                require("spectre").toggle()
            end,
            desc = "Spectre: Toggle Spectre",
        },
        {
            "<leader>rw",
            function()
                require("spectre").open_visual({ select_word = true })
            end,
            desc = "Spectre: Search current word",
        },
        {
            "<leader>rw",
            function()
                require("spectre").open_visual()
            end,
            desc = "Spectre: Search current word",
            mode = "v",
        },
        {
            "<leader>rf",
            function()
                require("spectre").open_file_search({ select_word = true })
            end,
            desc = "Spectre: Search current file",
        },
    },
    opts = {
        is_insert_mode = true,
        find_engine = {
            -- rg is map with finder_cmd
            ["rg"] = {
                cmd = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--hidden",
                    "--glob",
                    "!**/.git/*",
                },
            },
        },
    },
}
