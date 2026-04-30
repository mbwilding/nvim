-- Cellular Automaton provides a bunch of fun things to do with your text.

return {
    "eandrju/cellular-automaton.nvim",
    lazy = true,
    keys = {
        {
            "<leader>Xr",
            "<CMD>CellularAutomaton make_it_rain<CR>",
            desc = "Cellular Automaton: Make It Rain",
        },
        {
            "<leader>Xg",
            "<CMD>CellularAutomaton game_of_life<CR>",
            desc = "Cellular Automaton: Game Of Life",
        },
        {
            "<leader>Xs",
            "<CMD>CellularAutomaton scramble<CR>",
            desc = "Cellular Automaton: Scramble",
        },
    },
}
