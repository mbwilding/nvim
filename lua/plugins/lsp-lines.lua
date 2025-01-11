return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    event = "LspAttach",
    keys = {
        {
            "<leader>ilt",
            function()
                require("lsp_lines").toggle()
            end,
            desc = "LSP Lines: Toggle",
        },
        {
            "<leader>ilc",
            function()
                local current_setting = vim.diagnostic.config().virtual_lines.only_current_line
                vim.diagnostic.config({
                    virtual_lines = {
                        only_current_line = not current_setting,
                    },
                })
            end,
            desc = "LSP Lines: Current Line Toggle",
        },
    },
    config = function()
        require("lsp_lines").setup()

        vim.diagnostic.config({
            virtual_text = false, -- Disables in-built
            virtual_lines = {
                only_current_line = true,
                highlight_whole_line = false,
            },
        })
    end,
}
