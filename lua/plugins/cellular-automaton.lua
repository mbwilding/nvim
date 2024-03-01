return {
    "eandrju/cellular-automaton.nvim",
    dependencies = {},
    config = function()
        vim.keymap.set("n", "<leader>xr", "<cmd>CellularAutomaton make_it_rain<CR>",
            { desc = "Cellular Automaton: Make it rain" })
        vim.keymap.set("n", "<leader>xg", "<cmd>CellularAutomaton game_of_life<CR>",
            { desc = "Cellular Automaton: Game of life" })
        vim.keymap.set("n", "<leader>xs", "<cmd>CellularAutomaton scramble<CR>",
            { desc = "Cellular Automaton: Scramble" })
    end,
}
