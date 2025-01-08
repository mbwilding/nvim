return {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local HEIGHT_RATIO = 0.8
        local WIDTH_RATIO = 0.2

        require("nvim-tree").setup({
            disable_netrw = true, -- Oil
            hijack_netrw = false, -- Oil
            respect_buf_cwd = true,
            sort = {
                sorter = "case_sensitive",
            },
            view = {
                relativenumber = false,
                number = true,
                width = function()
                    return math.floor(vim.opt.columns:get() * WIDTH_RATIO)
                end,
                -- float = {
                --     enable = true,
                --     open_win_config = function()
                --         local screen_w = vim.opt.columns:get()
                --         local screen_h = vim.opt.lines:get() - vim.opt.cmdheight:get()
                --         local window_w = screen_w * WIDTH_RATIO
                --         local window_h = screen_h * HEIGHT_RATIO
                --         local window_w_int = math.floor(window_w)
                --         local window_h_int = math.floor(window_h)
                --         local center_x = (screen_w - window_w) / 2
                --         local center_y = ((vim.opt.lines:get() - window_h) / 2) - vim.opt.cmdheight:get()
                --         return {
                --             border = "rounded",
                --             relative = "editor",
                --             row = center_y,
                --             col = center_x,
                --             width = window_w_int,
                --             height = window_h_int,
                --         }
                --     end,
                -- },
            },
            renderer = {
                group_empty = true,
            },
            filters = {
                dotfiles = false,
            },
            diagnostics = {
                enable = true,
            },
        })

        vim.keymap.set("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "NvimTree" })
    end,
}
