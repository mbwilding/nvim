return {
    "jiaoshijie/undotree",
    keys = {
        {
            "<leader>u",
            function()
                require("undotree").toggle()
            end,
            "UndoTree",
        },
    },
    ---@module "undotree.collector"
    ---@type UndoTreeCollector.Opts
    opts = {
        float_diff = false,
        layout = "left_bottom",
        position = "left",
        keymaps = {
            j = "move_next",
            k = "move_prev",
            gj = "move2parent",
            J = "move_change_next",
            K = "move_change_prev",
            ["<cr>"] = "action_enter",
            p = "enter_diffbuf",
            q = "quit",
        },
    },
}
