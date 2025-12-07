return {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    branch = "stable",
    keys = {
        {
            "<leader>e",
            "<CMD>Fyler<CR>",
            desc = "Fyler",
        },
    },
    opts = {
        hooks = {
            on_rename = function(src_path, destination_path)
                Snacks.rename.on_rename_file(src_path, destination_path)
            end,
        },
    },
}
