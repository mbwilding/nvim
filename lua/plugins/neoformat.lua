return {
    "sbdchd/neoformat",
    config = function()
        vim.api.nvim_create_autocmd('FileType', {
            pattern = 'javascript',
            command = 'setlocal formatprg=prettier --single-quote --trailing-comma es5'
        })

        -- Use formatprg when available
        vim.g.neoformat_try_formatprg = 1

        --vim.keymap.set("n", "<leader>f", "<cmd>:Neoformat<CR>")
    end
}
