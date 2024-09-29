return {
    "akinsho/nvim-toggleterm.lua",
    config = function()
        local toggle_term = require("toggleterm")

        local shell_command
        if vim.fn.has("win32") == 1 then
            shell_command = "pwsh.exe -NoLogo"
        else
            shell_command = nil
        end

        toggle_term.setup({
            -- open_mapping = [[<c-\>]],
            start_in_insert = true,
            terminal_mappings = false,
            insert_mappings = false,
            -- direction = "float",
            shell = shell_command,
            auto_scroll = true,
            -- persist_mode = false,
            persist_size = true,
            close_on_exit = true,
            hide_numbers = true,
            shade_terminals = false,
        })

        vim.keymap.set("n", "<leader>th", "<CMD>:1ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm: Horizontal 1" })
        vim.keymap.set("n", "<leader>tt", "<CMD>:2ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm: Horizontal 2" })
        vim.keymap.set("n", "<leader>tn", "<CMD>:3ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm: Horizontal 3" })
        vim.keymap.set("n", "<leader>ts", "<CMD>:4ToggleTerm direction=horizontal<CR>", { desc = "ToggleTerm: Horizontal 4" })
        vim.keymap.set("n", "<leader>tc", "<CMD>:ToggleTermToggleAll<CR>", { desc = "ToggleTerm: Toggle All" })

        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
            vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
    end,
}
