return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "b0o/schemastore.nvim",
        "nvim-telescope/telescope.nvim"
    },
    config = function()
        -- These can have more fields like cmd, settings and filetypes
        local servers = {
            --"bashls",
            clangd = {},
            rust_analyzer = {},
            omnisharp = {},
            powershell_es = {
                init_options = {
                    enableProfileLoading = false,
                },
            },
            tsserver = {},
            tailwindcss = {},
            taplo = {},
            sqls = {},
            pylsp = {},
            jqls = {},
            jsonls = {},
            eslint = {},
            asm_lsp = {},
            yamlls = {
                settings = {
                    yaml = {
                        -- Specify AWS CloudFormation specific settings
                        customTags = {
                            -- AWS CloudFormation
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
                            "!Or mapping",
                            -- GitLab
                            "!reference sequence"
                        },
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    }
                }
            },
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = 'LuaJIT' },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                '${3rd}/luv/library',
                                unpack(vim.api.nvim_get_runtime_file('', true)),
                            },
                        },
                        completion = {
                            callSnippet = 'Replace',
                        },
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
        }

        require("mason").setup()
        vim.keymap.set("n", "<leader>M", "<cmd>Mason<CR>", { silent = true, desc = "Tool: Mason" })

        require("mason-lspconfig").setup_handlers {
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler
                if not servers[server_name] then
                    require("lspconfig")[server_name].setup {}
                end
            end,
        }
        require("mason-lspconfig").setup({
            automatic_installation = false,
            -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    local capabilities = vim.lsp.protocol.make_client_capabilities()

                    -- UFO (Folding)
                    capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true
                    }

                    require("lspconfig")[server_name].setup {
                        cmd = server.cmd,
                        settings = server.settings,
                        filetypes = server.filetypes,
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities()),
                    }
                end,
            },
        })

        -- Global mappings.
        -- See `:help vim.diagnostic.*` for documentation on any of the below functions

        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Diagnostic: Open float" })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Diagnostic: Goto previous" })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Diagnostic: Goto next" })
        vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Diagnostic: Open list" })

        vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
                -- NOTE: Remember that lua is a real programming language, and as such it is possible
                -- to define small helper and utility functions so you don't have to repeat yourself
                -- many times.
                --
                -- In this case, we create a function that lets us more easily define mappings specific
                -- for LSP related items. It sets the mode, buffer and description for us each time.
                local map = function(keys, func, desc)
                    vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
                end

                -- Formats the current buffer
                map('<leader>f', function()
                    vim.lsp.buf.format { async = true }
                end, 'Format')

                -- Jump to the definition of the word under your cursor.
                --  This is where a variable was first declared, or where a function is defined, etc.
                --  To jump back, press <C-T>.
                map('gd', require('telescope.builtin').lsp_definitions, 'LSP: Goto definition')

                -- WARN: This is not Goto Definition, this is Goto Declaration.
                --  For example, in C this would take you to the header
                map('gD', vim.lsp.buf.declaration, 'LSP: Goto declaration')

                -- Jump to the type of the word under your cursor.
                --  Useful when you're not sure what type a variable is and you want to see
                --  the definition of its *type*, not where it was *defined*.
                map('gt', require('telescope.builtin').lsp_type_definitions, 'LSP: Type definition')

                -- Find references for the word under your cursor.
                map('gr', require('telescope.builtin').lsp_references, 'LSP: Goto references')

                -- Jump to the implementation of the word under your cursor.
                --  Useful when your language has ways of declaring types without an actual implementation.
                map('gi', require('telescope.builtin').lsp_implementations, 'LSP: Goto implementation')

                -- Fuzzy find all the symbols in your current document.
                --  Symbols are things like variables, functions, types, etc.
                map('gs', require('telescope.builtin').lsp_document_symbols,
                    'LSP: Document symbols')

                -- Fuzzy find all the symbols in your current workspace
                --  Similar to document symbols, except searches over your whole project.
                map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols,
                    'LSP: Workspace symbols')

                -- Rename the variable under your cursor [Disabled due to inc-rename]
                --map('<leader>rn', vim.lsp.buf.rename, 'Rename')

                -- Execute a code action, usually your cursor needs to be on top of an error
                -- or a suggestion from your LSP for this to activate.

                --map('<leader>a', function()
                --    vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
                --end, 'Code action')

                -- Opens a popup that displays documentation about the word under your cursor
                --  See `:help K` for why this keymap
                map('K', vim.lsp.buf.hover, 'LSP: Hover documentation')

                -- Show the signature of the function you're currently completing.
                map('<C-k>', vim.lsp.buf.signature_help, 'LSP: Signature documentation')

                -- Navigation
                vim.api.nvim_set_keymap('n', '<C-p>', '<C-t>', { noremap = true, silent = true })
                vim.api.nvim_set_keymap('n', '<C-n>', ':tag<CR>', { noremap = true, silent = true })

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).

                --vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                --    buffer = event.buf,
                --    callback = vim.lsp.buf.document_highlight,
                --})

                --vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                --    buffer = event.buf,
                --    callback = vim.lsp.buf.clear_references,
                --})

                vim.lsp.inlay_hint.enable(event.buf, true)

                vim.keymap.set('n', '<leader>ih', function()
                    local bufnr = vim.api.nvim_get_current_buf()
                    vim.lsp.inlay_hint.enable(bufnr, not vim.lsp.inlay_hint.is_enabled(bufnr))
                end, { noremap = true, silent = true, desc = "LSP: Toggle inlay hints" })
            end,
        })
    end
}
