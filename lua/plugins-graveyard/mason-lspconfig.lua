return {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "neovim/nvim-lspconfig",
        "saghen/blink.cmp",
        "b0o/schemastore.nvim",
        "Issafalcon/lsp-overloads.nvim",
        "kevinhwang91/nvim-ufo",
        -- "Hoffs/omnisharp-extended-lsp.nvim",
        -- "Decodetalkers/csharpls-extended-lsp.nvim",

        {
            "seblj/roslyn.nvim",
            ft = "cs",
            opts = {
                config = {
                    capabilities = (function()
                        local capabilities = require("blink.cmp").get_lsp_capabilities()

                        -- UFO (Folding)
                        if pcall(require, "ufo") then
                            capabilities.textDocument.foldingRange = {
                                dynamicRegistration = false,
                                lineFoldingOnly = true,
                            }
                        end

                        return capabilities
                    end)(),
                    settings = {
                        ["csharp|background_analysis"] = {
                            dotnet_analyzer_diagnostics_scope = "fullSolution",
                            dotnet_compiler_diagnostics_scope = "fullSolution",
                        },
                        ["csharp|code_lens"] = {
                            dotnet_enable_references_code_lens = true,
                            dotnet_enable_tests_code_lens = true,
                        },
                        ["csharp|completion"] = {
                            dotnet_provide_regex_completions = true,
                            dotnet_show_completion_items_from_unimported_namespaces = true,
                            dotnet_show_name_completion_suggestions = true,
                        },
                        ["csharp|inlay_hints"] = {
                            csharp_enable_inlay_hints_for_implicit_object_creation = true,
                            csharp_enable_inlay_hints_for_implicit_variable_types = true,
                            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
                            csharp_enable_inlay_hints_for_types = true,
                            dotnet_enable_inlay_hints_for_indexer_parameters = true,
                            dotnet_enable_inlay_hints_for_literal_parameters = true,
                            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
                            dotnet_enable_inlay_hints_for_other_parameters = true,
                            dotnet_enable_inlay_hints_for_parameters = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
                            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
                        },
                        ["csharp|symbol_search"] = {
                            dotnet_search_reference_assemblies = true,
                        },
                        ["csharp|formatting"] = {
                            dotnet_organize_imports_on_format = true,
                        },
                    },
                },
            },
        },
    },
    config = function()
        -- These can have more fields like cmd, settings and filetypes
        local servers = {
            arduino_language_server = {},
            zls = {},
            bashls = {
                filetypes = { "sh", "zsh", "zshrc" },
            },
            clangd = {},
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        inlayHints = {
                            reborrowHints = { enable = "always" },
                            lifetimeElisionHints = { enable = "always" },
                            implicitDrops = { enable = true },
                        },
                    },
                },
            },
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
            -- nginx_language_server = {},
            -- vtsls = {
            --     settings = {
            --         javascript = {
            --             inlayHints = {
            --                 functionLikeReturnTypes = {
            --                     enabled = true,
            --                 },
            --                 parameterNames = {
            --                     enabled = "all",
            --                     suppressWhenArgumentMatchesName = true,
            --                 },
            --                 parameterTypes = {
            --                     enabled = true,
            --                 },
            --                 propertyDeclarationTypes = {
            --                     enabled = true,
            --                 },
            --                 variableTypes = {
            --                     enabled = true,
            --                     suppressWhenTypeMatchesName = true,
            --                 },
            --             },
            --         },
            --         typescript = {
            --             inlayHints = {
            --                 functionLikeReturnTypes = {
            --                     enabled = true,
            --                 },
            --                 parameterNames = {
            --                     enabled = "all",
            --                     suppressWhenArgumentMatchesName = true,
            --                 },
            --                 parameterTypes = {
            --                     enabled = true,
            --                 },
            --                 propertyDeclarationTypes = {
            --                     enabled = true,
            --                 },
            --                 variableTypes = {
            --                     enabled = true,
            --                     suppressWhenTypeMatchesName = true,
            --                 },
            --             },
            --         },
            --     },
            -- },
            -- volar = {},
            vuels = {},
            -- ts_ls = {
            --     enabled = false,
            --     settings = {
            --         javascript = {
            --             preferences = {
            --                 quoteStyle = "single",
            --             },
            --             inlayHints = {
            --                 enumMemberValues = {
            --                     enabled = true,
            --                 },
            --                 functionLikeReturnTypes = {
            --                     enabled = true,
            --                 },
            --                 parameterNames = {
            --                     enabled = true,
            --                     suppressWhenArgumentMatchesName = true,
            --                 },
            --                 parameterTypes = {
            --                     enabled = true,
            --                 },
            --                 propertyDeclarationTypes = {
            --                     enabled = true,
            --                 },
            --                 variableTypes = {
            --                     enabled = true,
            --                     suppressWhenTypeMatchesName = true,
            --                 },
            --             },
            --         },
            --         typescript = {
            --             format = {
            --                 semicolons = "insert",
            --             },
            --             preferences = {
            --                 quoteStyle = "single",
            --             },
            --             inlayHints = {
            --                 enumMemberValues = {
            --                     enabled = true,
            --                 },
            --                 functionLikeReturnTypes = {
            --                     enabled = true,
            --                 },
            --                 parameterNames = {
            --                     enabled = true,
            --                     suppressWhenArgumentMatchesName = true,
            --                 },
            --                 parameterTypes = {
            --                     enabled = true,
            --                 },
            --                 propertyDeclarationTypes = {
            --                     enabled = true,
            --                 },
            --                 variableTypes = {
            --                     enabled = true,
            --                     suppressWhenTypeMatchesName = true,
            --                 },
            --             },
            --         },
            --     },
            -- },
            taplo = {},
            sqls = {},
            pylsp = {},
            jqls = {},
            jsonls = {},
            -- typos_lsp = {},
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
                                { "cx\\(([^)]*)\\)", "[\"'`]?([^\"'`]*).*?[\"'`]?" },
                            },
                        },
                    },
                },
                filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
            },
            glsl_analyzer = {},
            yamlls = {
                settings = {
                    yaml = {
                        format = {
                            enable = true,
                        },
                        completion = true,
                        hover = true,
                        schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                        customTags = {
                            -- AWS CloudFormation
                            "!And mapping",
                            "!And sequence",
                            "!And",
                            "!Base64",
                            "!Cidr",
                            "!Condition",
                            "!Equals mapping",
                            "!Equals sequence",
                            "!Equals",
                            "!FindInMap sequence",
                            "!GetAZs",
                            "!GetAtt",
                            "!If mapping",
                            "!If sequence",
                            "!If",
                            "!ImportValue mapping",
                            "!ImportValue",
                            "!Join mapping",
                            "!Join sequence",
                            "!Not mapping",
                            "!Not sequence",
                            "!Not",
                            "!Or mapping",
                            "!Or sequence",
                            "!Or",
                            "!Ref Scalar",
                            "!Ref sequence",
                            "!Ref",
                            "!Select mapping",
                            "!Select sequence",
                            "!Select",
                            "!Split mapping",
                            "!Split sequence",
                            "!Split",
                            "!Sub sequence",
                            "!Sub",
                            "!fn",
                            -- GitLab
                            "!reference sequence",
                        },
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
            roslyn = {
                enabled = true,
                custom = true,
            },
            -- csharp_ls = {
            --     enabled = true,
            --     handlers = {
            --         ["textDocument/definition"] = require("csharpls_extended").handler,
            --         ["textDocument/typeDefinition"] = require("csharpls_extended").handler,
            --     },
            -- },
            -- omnisharp = {
            --     enabled = false,
            --     settings = {
            --         csharp = {
            --             inlayHints = {
            --                 enableInlayHintsForImplicitObjectCreation = true,
            --                 enableInlayHintsForImplicitVariableTypes = true,
            --                 enableInlayHintsForLambdaParameterTypes = true,
            --                 enableInlayHintsForTypes = true,
            --             },
            --             debug = {
            --                 -- console = "internalConsole",
            --                 -- enableStepFiltering = true,
            --                 expressionEvaluationOptions = {
            --                     -- allowFastEvaluate = true,
            --                     -- allowImplicitFuncEval = true,
            --                     -- allowToString = true,
            --                     -- showRawValues = false,
            --                 },
            --                 -- justMyCode = true,
            --                 logging = {
            --                     -- browserStdOut = true,
            --                     -- consoleUsageMessage = true,
            --                     diagnosticsLog = {
            --                         -- debugEngineAPITracing = "none",
            --                         -- debugRuntimeEventTracing = false,
            --                         -- dispatcherMessages = "none",
            --                         -- expressionEvaluationTracing = false,
            --                         -- protocolMessages = false,
            --                         -- startDebuggingTracing = false,
            --                     },
            --                     -- elapsedTiming = false,
            --                     -- engineLogging = false,
            --                     -- exceptions = true,
            --                     -- moduleLoad = true,
            --                     -- processExit = true,
            --                     -- programOutput = true,
            --                     -- threadExit = false,
            --                 },
            --                 -- requireExactSource = true,
            --                 -- sourceFileMap = {},
            --                 -- stopAtEntry = false,
            --                 -- suppressJITOptimizations = false,
            --                 symbolOptions = {
            --                     -- cachePath = "",
            --                     moduleFilter = {
            --                         -- excludedModules = {},
            --                         -- includeSymbolsNextToModules = true,
            --                         -- includeSymbolsOnDemand = true,
            --                         -- includedModules = {},
            --                         -- mode = "loadAllButExcluded",
            --                     },
            --                     searchMicrosoftSymbolServer = true,
            --                     searchNuGetOrgSymbolServer = true,
            --                     -- searchPaths = {},
            --                 },
            --             },
            --             format = {
            --                 -- enable = true,
            --             },
            --             -- maxProjectFileCountForDiagnosticAnalysis = 1000,
            --             referencesCodeLens = {
            --                 -- filteredSymbols = {},
            --             },
            --             -- semanticHighlighting.enabled = true,
            --             -- showOmnisharpLogOnError = true,
            --             -- suppressBuildAssetsNotification = false,
            --             -- suppressDotnetInstallWarning = false,
            --             -- suppressDotnetRestoreNotification = false,
            --             -- suppressHiddenDiagnostics = true,
            --             -- suppressProjectJsonWarning = false,
            --         },
            --         dotnet = {
            --             -- defaultSolution = "",
            --             backgroundAnalysis = {
            --                 -- analyzerDiagnosticsScope = "openFiles",
            --                 -- compilerDiagnosticsScope = "openFiles",
            --             },
            --             codeLens = {
            --                 -- enableReferencesCodeLens = true,
            --                 -- enableTestsCodeLens = true,
            --             },
            --             completion = {
            --                 -- provideRegexCompletions = "true",
            --                 -- showCompletionItemsFromUnimportedNamespaces = true,
            --                 -- showNameCompletionSuggestions = "true",
            --             },
            --             highlighting = {
            --                 -- highlightRelatedJsonComponents = "true",
            --                 -- highlightRelatedRegexComponents = "true",
            --             },
            --             implementType = {
            --                 -- insertionBehavior = "withOtherMembersOfTheSameKind",
            --                 -- propertyGenerationBehavior = "preferThrowingProperties",
            --             },
            --             inlayHints = {
            --                 enableInlayHintsForIndexerParameters = true,
            --                 enableInlayHintsForLiteralParameters = true,
            --                 enableInlayHintsForObjectCreationParameters = true,
            --                 enableInlayHintsForOtherParameters = true,
            --                 enableInlayHintsForParameters = true,
            --                 suppressInlayHintsForParametersThatDifferOnlyBySuffix = true,
            --                 suppressInlayHintsForParametersThatMatchArgumentName = true,
            --                 suppressInlayHintsForParametersThatMatchMethodIntent = true,
            --             },
            --             -- navigation.navigateToDecompiledSources = "true",
            --             -- quickInfo.showRemarksInQuickInfo = "true",
            --             -- symbolSearch.searchReferenceAssemblies = true,
            --             -- unitTestDebuggingOptions = {},
            --             -- unitTests.runSettingsPath = "",
            --             -- dotnetPath = "",
            --             -- enableXamlTools = true,
            --             -- preferCSharpExtension = false,
            --             -- projects.binaryLogPath = "",
            --             -- projects.enableAutomaticRestore = true,
            --             -- server.componentPaths = {},
            --             -- server.crashDumpPath = "",
            --             -- server.extensionPaths = {},
            --             -- server.path = "",
            --             -- server.startTimeout = 30000,
            --             -- server.suppressLspErrorToasts = false,
            --             -- server.trace = "Information",
            --             -- server.waitForDebugger = false,
            --         },
            --         omnisharp = {
            --             enableAsyncCompletion = true,
            --             enableDecompilationSupport = true,
            --             -- enableEditorConfigSupport = true,
            --             enableLspDriver = true,
            --             -- enableMsBuildLoadProjectsOnDemand = false,
            --             -- loggingLevel = "information",
            --             -- maxFindSymbolsItems = 1000,
            --             -- maxProjectResults = 250,
            --             -- minFindSymbolsFilterLength = 0,
            --             -- monoPath = "",
            --             organizeImportsOnFormat = true,
            --             -- projectFilesExcludePattern = "**/node_modules/**,**/.git/**,**/bower_components/**",
            --             -- projectLoadTimeout = 60,
            --             sdkIncludePrereleases = true,
            --             -- sdkPath = "",
            --             -- sdkVersion = "",
            --             -- useEditorFormattingSettings = true,
            --             -- useModernNet = true,
            --         },
            --         razor = {
            --             -- languageServer.debug = false,
            --             -- languageServer.directory = "",
            --             -- languageServer.forceRuntimeCodeGeneration = false,
            --             -- server.trace = "Information",
            --             -- completion.commitElementsWithSpace = "false",
            --             -- devmode = false,
            --             -- format.codeBlockBraceOnNextLine = false,
            --             -- format.enable = true,
            --             -- plugin.path = "",
            --         },
            --     },
            --     on_attach = function(_, bufnr)
            --         map("gd", require("omnisharp_extended").telescope_lsp_definition, "Telescope Definition", bufnr)
            --         map(
            --             "<leader>D",
            --             require("omnisharp_extended").telescope_lsp_type_definition,
            --             "Telescope Type Definition",
            --             bufnr
            --         )
            --         map("gr", require("omnisharp_extended").telescope_lsp_references, "Telescope References", bufnr)
            --         map(
            --             "gi",
            --             require("omnisharp_extended").telescope_lsp_implementation,
            --             "Telescope Implementation",
            --             bufnr
            --         )
            --     end,
            -- },
        }

        require("mason").setup({
            max_concurrent_installers = 10,
            registries = {
                "github:mason-org/mason-registry",
                "github:crashdummyy/mason-registry",
            },
        })

        require("mason-lspconfig").setup({
            automatic_installation = true,
            -- https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers
            ensure_installed = vim.tbl_filter(function(key)
                return servers[key].enabled ~= false and servers[key].custom ~= true
            end, vim.tbl_keys(servers)),
            handlers = {
                function(server_name)
                    local server = servers[server_name] or {}

                    -- Early exit if disabled
                    if server.enabled == false then
                        return
                    end

                    local capabilities = require("blink.cmp").get_lsp_capabilities(server.capabilities)

                    -- UFO (Folding)
                    if pcall(require, "ufo") then
                        capabilities.textDocument.foldingRange = {
                            dynamicRegistration = false,
                            lineFoldingOnly = true,
                        }
                    end

                    require("lspconfig")[server_name].setup({
                        cmd = server.cmd,
                        settings = server.settings,
                        filetypes = server.filetypes,
                        handlers = server.handlers,
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
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
