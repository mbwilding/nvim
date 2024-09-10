return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "b0o/schemastore.nvim",
        "nvim-telescope/telescope.nvim",
        "Issafalcon/lsp-overloads.nvim",
        "Hoffs/omnisharp-extended-lsp.nvim",
        -- "Decodetalkers/csharpls-extended-lsp.nvim",
    },
    config = function()
        local function map(keys, func, desc, bufnr)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        local servers = {
            rust_analyzer = {},
            clangd = {},
            typos_lsp = {},
            mesonlsp = {},
            vuels = {},
            arduino_language_server = {},
            zls = {},
            gopls = {},
            docker_compose_language_service = {},
            dockerls = {},
            sqls = {},
            nil_ls = {},
            taplo = {},
            jqls = {},
            pyright = {},
            glsl_analyzer = {},
            htmx = {},
            bashls = {
                filetypes = { "sh", "zsh", "zshrc" }
            },
            lemminx = {
                settings = {
                    xml = {
                        validation = {
                            filters = {
                                {
                                    pattern = "**.*sproj",
                                    noGrammar = "ignore",
                                },
                            },
                        },
                    },
                },
            },
            tailwindcss = {
                settings = {
                    tailwindCSS = {
                        experimental = {
                            classRegex = {
                                { "cva\\(([^)]*)\\)", "[\"'`]?([^\"'`]*).*?[\"'`]?" },
                                { "cx\\(([^)]*)\\)",  "[\"'`]?([^\"'`]*).*?[\"'`]?" }
                            },
                        },
                    },
                },
                filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
            },
            yamlls = {
                settings = {
                    yaml = {
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
                            "!reference sequence",
                        },
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            },
            lua_ls = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                "${3rd}/luv/library",
                                unpack(vim.api.nvim_get_runtime_file("", true)),
                            },
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        -- diagnostics = {
                        --     disable = {
                        --         "missing-fields"
                        --     }
                        -- },
                    },
                },
            },
            ts_ls = {
                settings = {
                    javascript = {
                        inlayHints = {
                            enumMemberValues = {
                                enabled = true
                            },
                            functionLikeReturnTypes = {
                                enabled = true
                            },
                            parameterNames = {
                                enabled = true,
                                suppressWhenArgumentMatchesName = true,
                            },
                            parameterTypes = {
                                enabled = true,
                            },
                            propertyDeclarationTypes = {
                                enabled = true,
                            },
                            variableTypes = {
                                enabled = true,
                                suppressWhenTypeMatchesName = true,
                            },
                        },
                    },
                    typescript = {
                        inlayHints = {
                            enumMemberValues = {
                                enabled = true
                            },
                            functionLikeReturnTypes = {
                                enabled = true
                            },
                            parameterNames = {
                                enabled = true,
                                suppressWhenArgumentMatchesName = true,
                            },
                            parameterTypes = {
                                enabled = true,
                            },
                            propertyDeclarationTypes = {
                                enabled = true,
                            },
                            variableTypes = {
                                enabled = true,
                                suppressWhenTypeMatchesName = true,
                            },
                        },
                    },
                },
            },
            omnisharp = {
                cmd = { "OmniSharp" },
                settings = {
                    csharp = {
                        inlayHints = {
                            enableInlayHintsForImplicitObjectCreation = true,
                            enableInlayHintsForImplicitVariableTypes = true,
                            enableInlayHintsForLambdaParameterTypes = true,
                            enableInlayHintsForTypes = true,
                        },
                        debug = {
                            symbolOptions = {
                                searchMicrosoftSymbolServer = true,
                                searchNuGetOrgSymbolServer = true,
                            },
                        },
                        format = {
                            enable = true,
                        },
                        maxProjectFileCountForDiagnosticAnalysis = 10000,
                    },
                    dotnet = {
                        inlayHints = {
                            enableInlayHintsForIndexerParameters = true,
                            enableInlayHintsForLiteralParameters = true,
                            enableInlayHintsForObjectCreationParameters = true,
                            enableInlayHintsForOtherParameters = true,
                            enableInlayHintsForParameters = true,
                            suppressInlayHintsForParametersThatDifferOnlyBySuffix = true,
                            suppressInlayHintsForParametersThatMatchArgumentName = true,
                            suppressInlayHintsForParametersThatMatchMethodIntent = true,
                        },
                    },
                    omnisharp = {
                        enableAsyncCompletion = true,
                        enableDecompilationSupport = true,
                        enableEditorConfigSupport = true,
                        enableLspDriver = true,
                        organizeImportsOnFormat = true,
                        sdkIncludePrereleases = true,
                    },
                },
                on_attach = function(client, bufnr)
                    map("gd", require("omnisharp_extended").telescope_lsp_definition, "Telescope Definition", bufnr)
                    map("<leader>D", require("omnisharp_extended").telescope_lsp_type_definition,
                        "Telescope Type Definition", bufnr)
                    map("gr", require("omnisharp_extended").telescope_lsp_references, "Telescope References", bufnr)
                    map("gi", require("omnisharp_extended").telescope_lsp_implementation, "Telescope Implementation",
                        bufnr)
                end,
            },
            ---- TODO
            -- html = {},
            -- azure_pipelines_ls = {},
            -- powershell_es = {
            --     settings = {
            --         powershell = {
            --             enableProfileLoading = false,
            --         },
            --     },
            -- },
            -- csharp_ls = {
            --     enabled = false,
            --     handlers = {
            --         ["textDocument/definition"] = require("csharpls_extended").handler,
            --         ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
            --     },
            -- },
        }

        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )

        ---- UFO (Folding)
        -- capabilities.textDocument.foldingRange = {
        --     dynamicRegistration = false,
        --     lineFoldingOnly = true,
        -- }

        for server_name, server in pairs(servers) do
            if server.enabled == false then
                return
            end

            require("lspconfig")[server_name].setup({
                cmd = server.cmd,
                settings = server.settings,
                filetypes = server.filetypes,
                handlers = server.handlers,
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    -- Enable inlay hints if supported
                    vim.lsp.inlay_hint.enable(server.forceInlayHints == true)
                    if client.server_capabilities.inlayHintProvider then
                        map("<leader>ih", function()
                            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                        end, "Inlay Hints", bufnr)
                    end

                    -- Set up mappings
                    map("gd", require("telescope.builtin").lsp_definitions, "Telescope Definition", bufnr)
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions,
                        "Telescope Type Definition", bufnr)
                    map("gr", require("telescope.builtin").lsp_references, "Telescope References", bufnr)
                    map("gi", require("telescope.builtin").lsp_implementations, "Telescope Implementation", bufnr)

                    -- Common mappings
                    map("<leader>f", function()
                        vim.lsp.buf.format({ async = true })
                    end, "Format", bufnr)
                    map("gD", vim.lsp.buf.declaration, "Goto Declaration", bufnr)
                    map("gs", require("telescope.builtin").lsp_document_symbols, "Telescope Document Symbols",
                        bufnr)
                    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols,
                        "Telescope Workspace Symbols", bufnr)
                    map("K", vim.lsp.buf.hover, "Hover Documentation", bufnr)
                    -- map("<C-k>", vim.lsp.buf.signature_help, "Signature documentation", bufnr)

                    -- Navigation
                    map("<C-p>", "<C-t>", "Navigate Previous", bufnr)
                    map("<C-n>", "<CMD>tag<CR>", "Navigate Next", bufnr)

                    -- Set up signature help overloads
                    if client.server_capabilities.signatureHelpProvider then
                        require("lsp-overloads").setup(client, {})
                    end

                    -- Call the server's on_attach, if it exists
                    if server.on_attach then
                        server.on_attach(client, bufnr)
                    end
                end,
            })
        end
    end
}
