-- Cellular Automaton provides a bunch of fun things to do with your text.

vim.pack.add({
    "https://github.com/eandrju/cellular-automaton.nvim",
}, { confirm = false })

vim.keymap.set(
    "n",
    "<leader>Xr",
    "<CMD>CellularAutomaton make_it_rain<CR>",
    { desc = "Cellular Automaton: Make It Rain" }
)

vim.keymap.set(
    "n",
    "<leader>Xg",
    "<CMD>CellularAutomaton game_of_life<CR>",
    { desc = "Cellular Automaton: Game Of Life" }
)

vim.keymap.set(
    "n",
    "<leader>Xg",
    "<CMD>CellularAutomaton scramble<CR>",
    { desc = "Cellular Automaton: Scramble" }
)
