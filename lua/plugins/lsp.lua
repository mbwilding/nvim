return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "b0o/schemastore.nvim",
        "nvim-telescope/telescope.nvim",
        "Issafalcon/lsp-overloads.nvim",
        "Hoffs/omnisharp-extended-lsp.nvim",
        "Decodetalkers/csharpls-extended-lsp.nvim",
    },
    config = function()
        -- on_attach function to overwrite the default keymaps
        local function map(keys, func, desc, bufnr)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
        end

        -- These can have more fields like cmd, settings and filetypes
        local servers = {
            arduino_language_server = {},
            volar = {},
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
            csharp_ls = {
                enabled = false,
                handlers = {
                    ["textDocument/definition"] = require("csharpls_extended").handler,
                    ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
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
                on_attach = function(client, bufnr)
                    map("gd", require("omnisharp_extended").telescope_lsp_definition, "Telescope Definition", bufnr)
                    map("<leader>D", require("omnisharp_extended").telescope_lsp_type_definition,
                        "Telescope Type Definition", bufnr)
                    map("gr", require("omnisharp_extended").telescope_lsp_references, "Telescope References", bufnr)
                    map("gi", require("omnisharp_extended").telescope_lsp_implementation, "Telescope Implementation",
                        bufnr)
                end,
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

        -- Capabilities
        local capabilities = vim.tbl_deep_extend(
            "force",
            vim.lsp.protocol.make_client_capabilities(),
            require("cmp_nvim_lsp").default_capabilities()
        )

        -- UFO (Folding)
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }

        require("mason-lspconfig").setup({
            automatic_installation = true,
            -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            ensure_installed = vim.tbl_keys(servers),
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}

                    -- Early exit if disabled
                    if server.enabled == false then
                        return
                    end

                    require("lspconfig")[server_name].setup({
                        cmd = server.cmd,
                        settings = server.settings,
                        filetypes = server.filetypes,
                        handlers = server.handlers,
                        -- This handles overriding only values explicitly passed
                        -- by the server configuration above. Useful when disabling
                        -- certain features of an LSP (for example, turning off formatting for tsserver)
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            -- Enable inlay hints if supported
                            if client.server_capabilities.inlayHintProvider then
                                vim.lsp.inlay_hint.enable(true)

                                map("<leader>f", function()
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
                            map("gs", require("telescope.builtin").lsp_document_symbols, "Telescope Document Symbols", bufnr)
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
                end,
            },
        })
    end,
}
