return {
    "eandrju/cellular-automaton.nvim",
    dependencies = {},
    config = function()
        local slide = {
            fps = 40,
            name = 'slide',
        }

        slide.update = function(grid)
            for i = 1, #grid do
                local prev = grid[i][#(grid[i])]
                for j = 1, #(grid[i]) do
                    grid[i][j], prev = prev, grid[i][j]
                end
            end
            return true
        end

        require("cellular-automaton").register_animation(slide)

        vim.keymap.set("n", "<leader>xl", "<cmd>CellularAutomaton slide<CR>",
            { desc = "Cellular Automaton: Slide" })
        vim.keymap.set("n", "<leader>xr", "<cmd>CellularAutomaton make_it_rain<CR>",
            { desc = "Cellular Automaton: Make it rain" })
        vim.keymap.set("n", "<leader>xg", "<cmd>CellularAutomaton game_of_life<CR>",
            { desc = "Cellular Automaton: Game of life" })
        vim.keymap.set("n", "<leader>xs", "<cmd>CellularAutomaton scramble<CR>",
            { desc = "Cellular Automaton: Scramble" })
    end,
}
