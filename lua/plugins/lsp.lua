return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "b0o/schemastore.nvim",
        "nvim-telescope/telescope.nvim",
        "Issafalcon/lsp-overloads.nvim",
        "Hoffs/omnisharp-extended-lsp.nvim",
    },
    config = function()
        -- These can have more fields like cmd, settings and filetypes
        local servers = {
            arduino_language_server = {},
            zls = {},
            bashls = {
                filetypes = { "sh", "zsh", "zshrc" }
            },
            clangd = {},
            rust_analyzer = {},
            gopls = {},
            mesonlsp = {},
            powershell_es = {
                settings = {
                    powershell = {
                        enableProfileLoading = false,
                    },
                },
            },
            html = {},
            azure_pipelines_ls = {},
            docker_compose_language_service = {},
            dockerls = {},
            tsserver = {
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
            taplo = {},
            sqls = {},
            pylsp = {},
            jqls = {},
            jsonls = {},
            typos_lsp = {},
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
            glsl_analyzer = {},
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
                        -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
            omnisharp = {
                settings = {
                    csharp = {
                        inlayHints = {
                            enableInlayHintsForImplicitObjectCreation = true,
                            enableInlayHintsForImplicitVariableTypes = true,
                            enableInlayHintsForLambdaParameterTypes = true,
                            enableInlayHintsForTypes = true,
                        },
                        debug = {
                            -- console = "internalConsole",
                            -- enableStepFiltering = true,
                            expressionEvaluationOptions = {
                                -- allowFastEvaluate = true,
                                -- allowImplicitFuncEval = true,
                                -- allowToString = true,
                                -- showRawValues = false,
                            },
                            -- justMyCode = true,
                            logging = {
                                -- browserStdOut = true,
                                -- consoleUsageMessage = true,
                                diagnosticsLog = {
                                    -- debugEngineAPITracing = "none",
                                    -- debugRuntimeEventTracing = false,
                                    -- dispatcherMessages = "none",
                                    -- expressionEvaluationTracing = false,
                                    -- protocolMessages = false,
                                    -- startDebuggingTracing = false,
                                },
                                -- elapsedTiming = false,
                                -- engineLogging = false,
                                -- exceptions = true,
                                -- moduleLoad = true,
                                -- processExit = true,
                                -- programOutput = true,
                                -- threadExit = false,
                            },
                            -- requireExactSource = true,
                            -- sourceFileMap = {},
                            -- stopAtEntry = false,
                            -- suppressJITOptimizations = false,
                            symbolOptions = {
                                -- cachePath = "",
                                moduleFilter = {
                                    -- excludedModules = {},
                                    -- includeSymbolsNextToModules = true,
                                    -- includeSymbolsOnDemand = true,
                                    -- includedModules = {},
                                    -- mode = "loadAllButExcluded",
                                },
                                searchMicrosoftSymbolServer = true,
                                searchNuGetOrgSymbolServer = true,
                                -- searchPaths = {},
                            },
                        },
                        format = {
                            -- enable = true,
                        },
                        -- maxProjectFileCountForDiagnosticAnalysis = 1000,
                        referencesCodeLens = {
                            -- filteredSymbols = {},
                        },
                        -- semanticHighlighting.enabled = true,
                        -- showOmnisharpLogOnError = true,
                        -- suppressBuildAssetsNotification = false,
                        -- suppressDotnetInstallWarning = false,
                        -- suppressDotnetRestoreNotification = false,
                        -- suppressHiddenDiagnostics = true,
                        -- suppressProjectJsonWarning = false,
                    },
                    dotnet = {
                        -- defaultSolution = "",
                        backgroundAnalysis = {
                            -- analyzerDiagnosticsScope = "openFiles",
                            -- compilerDiagnosticsScope = "openFiles",
                        },
                        codeLens = {
                            -- enableReferencesCodeLens = true,
                            -- enableTestsCodeLens = true,
                        },
                        completion = {
                            -- provideRegexCompletions = "true",
                            -- showCompletionItemsFromUnimportedNamespaces = true,
                            -- showNameCompletionSuggestions = "true",
                        },
                        highlighting = {
                            -- highlightRelatedJsonComponents = "true",
                            -- highlightRelatedRegexComponents = "true",
                        },
                        implementType = {
                            -- insertionBehavior = "withOtherMembersOfTheSameKind",
                            -- propertyGenerationBehavior = "preferThrowingProperties",
                        },
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
                        -- navigation.navigateToDecompiledSources = "true",
                        -- quickInfo.showRemarksInQuickInfo = "true",
                        -- symbolSearch.searchReferenceAssemblies = true,
                        -- unitTestDebuggingOptions = {},
                        -- unitTests.runSettingsPath = "",
                        -- dotnetPath = "",
                        -- enableXamlTools = true,
                        -- preferCSharpExtension = false,
                        -- projects.binaryLogPath = "",
                        -- projects.enableAutomaticRestore = true,
                        -- server.componentPaths = {},
                        -- server.crashDumpPath = "",
                        -- server.extensionPaths = {},
                        -- server.path = "",
                        -- server.startTimeout = 30000,
                        -- server.suppressLspErrorToasts = false,
                        -- server.trace = "Information",
                        -- server.waitForDebugger = false,
                    },
                    omnisharp = {
                        enableAsyncCompletion = true,
                        enableDecompilationSupport = true,
                        -- enableEditorConfigSupport = true,
                        enableLspDriver = true,
                        -- enableMsBuildLoadProjectsOnDemand = false,
                        -- loggingLevel = "information",
                        -- maxFindSymbolsItems = 1000,
                        -- maxProjectResults = 250,
                        -- minFindSymbolsFilterLength = 0,
                        -- monoPath = "",
                        organizeImportsOnFormat = true,
                        -- projectFilesExcludePattern = "**/node_modules/**,**/.git/**,**/bower_components/**",
                        -- projectLoadTimeout = 60,
                        sdkIncludePrereleases = true,
                        -- sdkPath = "",
                        -- sdkVersion = "",
                        -- useEditorFormattingSettings = true,
                        -- useModernNet = true,
                    },
                    razor = {
                        -- languageServer.debug = false,
                        -- languageServer.directory = "",
                        -- languageServer.forceRuntimeCodeGeneration = false,
                        -- server.trace = "Information",
                        -- completion.commitElementsWithSpace = "false",
                        -- devmode = false,
                        -- format.codeBlockBraceOnNextLine = false,
                        -- format.enable = true,
                        -- plugin.path = "",
                    },
                },
            },
        }

        require("mason").setup({
            max_concurrent_installers = 10,
        })

        require("mason-lspconfig").setup_handlers({
            -- The first entry (without a key) will be the default handler
            -- and will be called for each installed server that doesn't have
            -- a dedicated handler.
            function(server_name) -- default handler
                if not servers[server_name] then
                    require("lspconfig")[server_name].setup({})
                end
            end,
        })

        require("mason-lspconfig").setup({
            automatic_installation = true,
            -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}
                    local capabilities = vim.lsp.protocol.make_client_capabilities()

                    -- UFO (Folding)
                    capabilities.textDocument.foldingRange = {
                        dynamicRegistration = false,
                        lineFoldingOnly = true,
                    }

                    require("lspconfig")[server_name].setup({
                        cmd = server.cmd,
                        settings = server.settings,
                        filetypes = server.filetypes,
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        capabilities = vim.tbl_deep_extend(
                            "force",
                            capabilities,
                            require("cmp_nvim_lsp").default_capabilities()
                        ),
                        on_attach = function(client, bufnr)
                            -- Enable inlay hints if supported
                            if client.server_capabilities.inlayHintProvider then
                                vim.lsp.inlay_hint.enable(true)
                            end
                        end,
                    })
                end,
            },
        })

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)

                if client and client.server_capabilities.signatureHelpProvider then
                    require("lsp-overloads").setup(client, {})
                end

                -- Function to create mappings
                local function map(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                if client and client.name == "omnisharp" then
                    map("gd", require("omnisharp_extended").telescope_lsp_definition, "Goto definition")
                    map("<leader>D", require("omnisharp_extended").telescope_lsp_type_definition, "Type definition")
                    map("gr", require("omnisharp_extended").telescope_lsp_references, "Goto references")
                    map("gi", require("omnisharp_extended").telescope_lsp_implementation, "Goto implementation")
                else
                    map("gd", require("telescope.builtin").lsp_definitions, "Goto definition")
                    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type definition")
                    map("gr", require("telescope.builtin").lsp_references, "Goto references")
                    map("gi", require("telescope.builtin").lsp_implementations, "Goto implementation")
                end

                -- Common mappings
                map("<leader>f", function()
                    vim.lsp.buf.format({ async = true })
                end, "Format")
                map("gD", vim.lsp.buf.declaration, "Goto declaration")
                map("gs", require("telescope.builtin").lsp_document_symbols, "Document symbols")
                map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace symbols")
                map("K", vim.lsp.buf.hover, "Hover documentation")
                -- map("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

                -- Navigation
                vim.api.nvim_set_keymap("n", "<C-p>", "<C-t>", {})
                vim.api.nvim_set_keymap("n", "<C-n>", ":tag<CR>", {})

                vim.keymap.set("n", "<leader>ih", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
                end, { desc = "LSP: Toggle inlay hints" })
            end,
        })
    end,
}
