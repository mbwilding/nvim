return {
    "nvim-pack/nvim-spectre",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = true,
    keys = {
        {
            "<leader>R",
            "<CMD>lua require('spectre').toggle()<CR>",
            desc = "Spectre: Toggle Spectre",
        },
        {
            "<leader>rw",
            "<CMD>lua require('spectre').open_visual({select_word=true})<CR>",
            desc = "Spectre: Search current word",
        },
        {
            "<leader>rw",
            "<ESC><CMD>lua require('spectre').open_visual()<CR>",
            desc = "Spectre: Search current word",
            mode = "v"
        },
        {
            "<leader>rf",
            "<CMD>lua require('spectre').open_file_search({select_word=true})<CR>",
            desc = "Spectre: Search current file",
        },
    },
    opts = {},
}
