return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = true,
            -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            ensure_installed = {
                --"bashls",
                "lua_ls",
                "clangd",
                "rust_analyzer",
                "omnisharp",
                "powershell_es",
                "yamlls",
                "tsserver",
                "tailwindcss",
                "taplo",
                --"sqls",
                "pylsp",
                "jqls",
                "jsonls",
                "eslint",
            }
        })

        require("mason-lspconfig").setup_handlers {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function (server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup {}
            end,
        }

        require('lspconfig')['lua_ls'].setup {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Recognize the `vim` global
                         globals = {'vim'},
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        }
    end
}
