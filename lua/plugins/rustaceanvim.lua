return {
    "mrcjkb/rustaceanvim",
    version = "^4",
    ft = { "rust" },
    init = function()
        vim.g.rustaceanvim = {
            -- Plugin configuration
            --tools = {},
            -- LSP configuration
            server = {
                on_attach = function(client, bufnr)
                    vim.keymap.set(
                        "n",
                        "<leader>a",
                        function()
                            vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
                            -- or vim.lsp.buf.codeAction() if you don't want grouping.
                        end,
                        { silent = true, buffer = bufnr, desc = "Rustacean: Code action" }
                    )
                end,
                default_settings = {
                    -- rust-analyzer language server configuration
                    ["rust-analyzer"] = {},
                },
            },
            -- DAP configuration
            --dap = {},
        }
    end
}
