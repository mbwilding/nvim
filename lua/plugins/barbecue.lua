return {
    -- "utilyre/barbecue.nvim",
    "mbwilding/barbecue.nvim",
    -- dev = true,
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons",
    },
    -- NOTE: Enabling keys causes barbecue to not run at start
    --
    -- keys = {
    --     {
    --         "<leader>ib",
    --         function()
    --             require("barbecue.ui").toggle()
    --         end,
    --         desc = "Barbecue: Toggle",
    --     },
    -- },
    opts = {
        -- Shows info on where you are in the file
        show_navic = false,
        icon_position = "after",
    },
    config = function(_, opts)
        require("barbecue").setup(opts)

        vim.keymap.set("n", "<leader>ib", function()
            require("barbecue.ui").toggle()
        end, { desc = "Barbecue: Toggle" })
    end,
}
