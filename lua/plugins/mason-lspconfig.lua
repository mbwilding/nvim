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
                        ["csharp|code_lens"] = {
                            dotnet_enable_references_code_lens = true,
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
            vtsls = {
                settings = {
                    javascript = {
                        inlayHints = {
                            functionLikeReturnTypes = {
                                enabled = true,
                            },
                            parameterNames = {
                                enabled = "all",
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
                            functionLikeReturnTypes = {
                                enabled = true,
                            },
                            parameterNames = {
                                enabled = "all",
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
            -- volar = {},
            vuels = {},
            ts_ls = {
                enabled = false,
                settings = {
                    javascript = {
                        preferences = {
                            quoteStyle = "single",
                        },
                        inlayHints = {
                            enumMemberValues = {
                                enabled = true,
                            },
                            functionLikeReturnTypes = {
                                enabled = true,
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
                        format = {
                            semicolons = "insert",
                        },
                        preferences = {
                            quoteStyle = "single",
                        },
                        inlayHints = {
                            enumMemberValues = {
                                enabled = true,
                            },
                            functionLikeReturnTypes = {
                                enabled = true,
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
            roslyn = {
                enabled = true,
                custom = true,
            },
            -- csharp_ls = {
            --     enabled = false,
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

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end

                -- Set up signature help overloads
                if client.server_capabilities.signatureHelpProvider then
                    ---@diagnostic disable-next-line: missing-fields
                    require("lsp-overloads").setup(client, {})
                end

                local map = function(keys, func, desc, mode)
                    mode = mode or "n"
                    vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                -- Format the buffer
                map("<leader>f", function()
                    vim.notify("Formatting", vim.log.levels.INFO)
                    vim.lsp.buf.format({ async = true })
                end, "Format")

                map("<leader>ih", function()
                    local enabled = not vim.lsp.inlay_hint.is_enabled()
                    vim.lsp.inlay_hint.enable(enabled)
                    vim.notify("Inlay Hints: " .. tostring(enabled), vim.log.levels.INFO)
                end, "Toggle [I]nlay [H]ints")

                -- The following two autocommands are used to highlight references of the
                -- word under your cursor when your cursor rests there for a little while.
                --    See `:help CursorHold` for information about when this is executed
                --
                -- When you move your cursor, the highlights will be cleared (the second autocommand).
                --
                -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
                --     local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
                --     vim.api.nvim_create_autocmd({ "CursorHold" }, { -- "CursorHoldI"
                --         buffer = event.buf,
                --         group = highlight_augroup,
                --         callback = vim.lsp.buf.document_highlight,
                --     })
                --
                --     vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter" }, {
                --         buffer = event.buf,
                --         group = highlight_augroup,
                --         callback = vim.lsp.buf.clear_references,
                --     })
                --
                --     vim.api.nvim_create_autocmd("LspDetach", {
                --         group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                --         callback = function(event2)
                --             vim.lsp.buf.clear_references()
                --             vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                --         end,
                --     })
                -- end
            end,
        })
    end,
}
