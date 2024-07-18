return {
    "eandrju/cellular-automaton.nvim",
    lazy = true,
    keys = {
        {
            "<leader>xr",
            "<CMD>CellularAutomaton make_it_rain<CR>",
            desc = "Cellular Automaton: Make It Rain",
        },
        {
            "<leader>xg",
            "<CMD>CellularAutomaton game_of_life<CR>",
            desc = "Cellular Automaton: Game Of Life",
        },
        {
            "<leader>xs",
            "<CMD>CellularAutomaton scramble<CR>",
            desc = "Cellular Automaton: Scramble",
        },
    },
}
