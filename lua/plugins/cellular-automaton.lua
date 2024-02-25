return {
    "eandrju/cellular-automaton.nvim",
    dependencies = {},
    config = function()
        vim.keymap.set("n", "<leader>car", "<cmd>CellularAutomaton make_it_rain<CR>",
            { desc = "Cellular Automaton: Make it rain" })
        vim.keymap.set("n", "<leader>cag", "<cmd>CellularAutomaton game_of_life<CR>",
            { desc = "Cellular Automaton: Game of life" })
        vim.keymap.set("n", "<leader>cas", "<cmd>CellularAutomaton scramble<CR>",
            { desc = "Cellular Automaton: Scramble" })
    end,
}
