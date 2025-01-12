local virtual_text = true
local only_current_line = true

return {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    lazy = true,
    event = "LspAttach",
    keys = {
        {
            "<leader>ilt",
            function()
                virtual_text = not virtual_text
                vim.diagnostic.config({
                    virtual_text = virtual_text,
                })
                require("lsp_lines").toggle()
            end,
            desc = "LSP Lines: Toggle",
        },
        {
            "<leader>ilc",
            function()
                only_current_line = not only_current_line
                vim.diagnostic.config({
                    virtual_lines = {
                        only_current_line = only_current_line,
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
                only_current_line = only_current_line,
                highlight_whole_line = false,
            },
        })

        local ll = require("lsp_lines")
        ll.setup()
        ll.toggle()
    end,
}
