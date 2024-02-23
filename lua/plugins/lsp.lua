return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "b0o/schemastore.nvim",
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
            function(server_name) -- default handler (optional)
                require("lspconfig")[server_name].setup {}
            end,
        }

        require('lspconfig')['lua_ls'].setup {
            settings = {
                Lua = {
                    diagnostics = {
                        -- Recognize the `vim` global
                        globals = { 'vim' },
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                },
            },
        }

        require('lspconfig')['yamlls'].setup {
            settings = {
                yaml = {
                    -- Specify AWS CloudFormation specific settings
                    customTags = {
                        "!Ref",
                        "!If sequence",
                        "!GetAtt",
                        "!GetAZs",
                        "!ImportValue",
                        "!ImportValue mapping",
                        "!Join sequence",
                        "!Sub",
                        "!Sub sequence",
                        "!FindInMap sequence",
                        "!Select sequence",
                        "!Split sequence",
                        "!Not sequence",
                        "!Equals sequence",
                        "!And sequence",
                        "!Or sequence",
                        "!Condition",
                        "!Base64",
                        "!Cidr",
                        "!Ref sequence",
                        "!If mapping",
                        "!Join mapping",
                        "!Select mapping",
                        "!Split mapping",
                        "!Not mapping",
                        "!Equals mapping",
                        "!And mapping",
                        "!Or mapping"
                    },
                    schemas = require("schemastore").json.schemas(),
                    validate = { enable = true },
                }
            }
        }

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions

        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Diagnostic: Open float" })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostic: Goto previous" })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostic: Goto next" })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostic: Open list" })

        -- Use LspAttach autocommand to only map the following keys
        -- after the language server attaches to the current buffer
        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
                -- Enable completion triggered by <c-x><c-o>
                vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                vim.keymap.set({ 'n', 'v' }, '<leader>aa', vim.lsp.buf.code_action,
                    { buffer = ev.buf, desc = "LSP: Code actions" })
                vim.keymap.set('n', '<leader>aD', vim.lsp.buf.declaration,
                    { buffer = ev.buf, desc = "LSP: Goto declaration" })
                vim.keymap.set('n', '<leader>ad', vim.lsp.buf.definition,
                    { buffer = ev.buf, desc = "LSP: Goto definition" })
                vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = ev.buf, desc = "LSP: Hover info" })
                vim.keymap.set('n', '<leader>ai', vim.lsp.buf.implementation,
                    { buffer = ev.buf, desc = "LSP: Goto implementation" })
                vim.keymap.set('n', '<leader>as', vim.lsp.buf.signature_help,
                    { buffer = ev.buf, desc = "LSP: Signature help" })
                vim.keymap.set('n', '<leader>ar', vim.lsp.buf.references,
                    { buffer = ev.buf, desc = "LSP: Show references" })
                vim.keymap.set('n', '<leader>ad', vim.lsp.buf.type_definition,
                    { buffer = ev.buf, desc = "LSP: Type definition" })

                vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder,
                    { buffer = ev.buf, desc = "LSP: Add workspace folder" })
                vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder,
                    { buffer = ev.buf, desc = "LSP: Remove workspace folder" })
                vim.keymap.set('n', '<leader>wl', function()
                    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                end, { buffer = ev.buf, desc = "LSP: List workspace folders" })

                vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "LSP: Rename" })
                vim.keymap.set('n', '<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, { buffer = ev.buf, desc = "LSP: Format buffer" })
            end
        })
    end
}
