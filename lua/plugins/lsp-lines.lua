local virtual_text = true

return {
    -- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    "mbwilding/lsp_lines.nvim",
    -- dev = true,
    lazy = true,
    event = "LspAttach",
    keys = {
        -- {
        --     "<leader>ilt",
        --     function()
        --         require("lsp_lines").toggle()
        --     end,
        --     desc = "LSP Lines: Toggle",
        -- },
        {
            "<leader>ilt",
            function()
                virtual_text = not virtual_text
                vim.diagnostic.config({
                    virtual_text = virtual_text,
                    virtual_lines = {
                        show_lines = not vim.diagnostic.config().virtual_lines.show_lines,
                    },
                })
            end,
            desc = "LSP Lines: Toggle",
        },
        {
            "<leader>ilc",
            function()
                vim.diagnostic.config({
                    virtual_lines = {
                        only_current_line = not vim.diagnostic.config().virtual_lines.only_current_line,
                    },
                })
            end,
            desc = "LSP Lines: Current Line Toggle",
        },
    },
    config = function()
        vim.diagnostic.config({
            virtual_text = virtual_text,
            virtual_lines = {
                show_lines = false,
                only_current_line = false,
                highlight_whole_line = false,
            },
        })

        require("lsp_lines").setup()
    end,
}
