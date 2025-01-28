return {
    "Bekaboo/dropbar.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        bar = {
            enable = function(buf, win, _)
                local ft = vim.bo[buf].filetype
                local bt = vim.bo[buf].buftype

                if
                    not vim.api.nvim_buf_is_valid(buf)
                    or not vim.api.nvim_win_is_valid(win)
                    or vim.fn.win_gettype(win) ~= ""
                    or vim.wo[win].winbar ~= ""
                    or ft == "help"
                    or ft == "noice"
                    or ft == "snacks_dashboard"
                    or bt == "terminal"
                then
                    return false
                else
                    -- print("----------")
                    -- print("ft: " .. ft)
                    -- print("bt: " .. bt)
                    -- print("----------")
                    return true
                end
            end,
        },
        sources = {
            path = {
                max_depth = 16,
            },
            treesitter = {
                max_depth = 0,
            },
            lsp = {
                max_depth = 0,
            },
            markdown = {
                max_depth = 0,
            },
            terminal = {
                show_current = false,
            },
        },
    },
}
