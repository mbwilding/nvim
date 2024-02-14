return {
    "eandrju/cellular-automaton.nvim",
    lazy = false,
    dependencies = {},
    config = function()
        vim.keymap.set("n", "<leader>car", "<cmd>CellularAutomaton make_it_rain<CR>")
        vim.keymap.set("n", "<leader>cag", "<cmd>CellularAutomaton game_of_life<CR>")
        vim.keymap.set("n", "<leader>cas", "<cmd>CellularAutomaton scramble<CR>")
    end,
}
