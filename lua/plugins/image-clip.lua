-- Image tools

vim.pack.add({
    "http://github.com/HakonHarnes/img-clip.nvim",
}, { confirm = false })

local opts = {
    -- recommended settings
    default = {
        embed_image_as_base64 = false,
        prompt_for_file_name = false,
        drag_and_drop = {
            insert_mode = true,
        },
        -- required for Windows users
        use_absolute_path = true,
    },
}

require("img-clip").setup(opts)
