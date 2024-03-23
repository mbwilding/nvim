return {
    "mbwilding/profiles.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim",
        "akinsho/nvim-toggleterm.lua"
    },
    config = function()
        local profiles = require("profiles")
        vim.keymap.set("n", "<leader>p", function()
            profiles.select_profile()
        end, { desc = "Profiles: Select" })
    end,
}
