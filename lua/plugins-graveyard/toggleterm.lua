return {
    "akinsho/nvim-toggleterm.lua",
    lazy = true,
    keys = {
        {
            "<leader>th",
            "<CMD>:1ToggleTerm direction=horizontal<CR>",
            desc = "ToggleTerm: Horizontal 1",
        },
        {
            "<leader>tt",
            "<CMD>:2ToggleTerm direction=horizontal<CR>",
            desc = "ToggleTerm: Horizontal 2",
        },
        {
            "<leader>tn",
            "<CMD>:3ToggleTerm direction=horizontal<CR>",
            desc = "ToggleTerm: Horizontal 3",
        },
        {
            "<leader>ts",
            "<CMD>:4ToggleTerm direction=horizontal<CR>",
            desc = "ToggleTerm: Horizontal 4",
        },
        {
            "<leader>tc",
            "<CMD>:ToggleTermToggleAll<CR>",
            desc = "ToggleTerm: Toggle All",
        },
    },
    opts = {
        auto_scroll = true,
        close_on_exit = true,
        hide_numbers = true,
        insert_mappings = false,
        persist_size = true,
        shade_terminals = false,
        start_in_insert = true,
        terminal_mappings = false,
    },
    config = function(_, opts)
        local toggle_term = require("toggleterm")

        local uname = vim.loop.os_uname().sysname
        if uname == "Windows_NT" then
            opts.shell = "pwsh -NoLogo"
        else
            opts.shell = "zsh"
        end

        toggle_term.setup(opts)

        function _G.set_terminal_keymaps()
            local opts = { buffer = 0 }
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
            vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
            vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
            vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
            vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
            vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
        end

        -- if you only want these mappings for toggle term use term://*toggleterm#* instead
        vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
    end,
}
