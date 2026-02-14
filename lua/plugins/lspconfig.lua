return {
    "neovim/nvim-lspconfig",
    dev = false,
    lazy = false,
    config = function()
        ---@type table<string, vim.lsp.Config>
        local servers = {
            ada_ls = {},
            clangd = {},
            docker_compose_language_service = {},
            dockerls = {},
            gopls = {},
            html = {},
            jsonls = {},
            phpactor = {},
            cssls = {
                capabilities = {
                    textDocument = {
                        completion = {
                            completionItem = {
                                snippetSupport = true,
                            },
                        },
                    },
                },
            },
            pyright = {
                settings = {
                    pyright = {
                        -- Using Ruff's import organizer
                        disableOrganizeImports = true,
                    },
                    python = {
                        analysis = {
                            -- Ignore all files for analysis to exclusively use Ruff for linting
                            ignore = { "*" },
                        },
                    },
                },
            },
            ruff = {},
            sqls = {},
            taplo = {},
            zls = {},
            tsgo = {},
            marksman = {},
            stylua = {},
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = {
                            -- NOTE: Work around for latest lua_ls version
                            -- vim global not being recognised
                            library = { vim.env.VIMRUNTIME },
                        },
                        runtime = {
                            version = "LuaJIT",
                        },
                    },
                },
            },
            bashls = {
                filetypes = { "sh", "zsh", "zshrc" },
            },
            rust_analyzer = {
                settings = {
                    ["rust-analyzer"] = {
                        -- diagnostics = {
                        --     disabled = { "inactive-code" },
                        -- },
                        inlayhints = {
                            -- reborrowhints = { enable = "always" },
                            -- lifetimeelisionhints = { enable = "always" },
                            -- implicitdrops = { enable = true },
                        },
                    },
                },
                on_attach = function(client, bufnr)
                    vim.keymap.set("n", "<leader>em", function()
                        local params = vim.lsp.util.make_position_params(0, client.offset_encoding or "utf-8")
                        ---@diagnostic disable-next-line: param-type-mismatch
                        vim.lsp.buf_request(bufnr, "rust-analyzer/expandMacro", params, function(err, result)
                            if err and err.message and not string.find(err.message, "Method not found") then
                                vim.notify("Error expanding macro: " .. err.message, vim.log.levels.ERROR)
                                return
                            end
                            if result and result.expansion then
                                local buf = vim.api.nvim_create_buf(false, true)
                                local lines = vim.split(result.expansion, "\n", { plain = true })
                                vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
                                vim.bo[buf].filetype = "rust"
                                vim.cmd("vsplit")
                                vim.api.nvim_win_set_buf(0, buf)
                                -- vim.lsp.buf_attach_client(buf, client.id)
                            end
                        end)
                    end, { desc = "LSP: Expand Macro" })
                end,
            },
            powershell_es = {
                bundle_path = (function()
                    return (jit.os == "OSX" and os.getenv("HOME") .. "/.lsp/powershell_es")
                        or (jit.os == "Linux" and "/opt/powershell-editor-services")
                end)(),
                settings = {
                    powershell = {
                        enableProfileLoading = false,
                    },
                },
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
                                { "cx\\(([^)]*)\\)", "[\"'`]?([^\"'`]*).*?[\"'`]?" },
                            },
                        },
                    },
                },
                filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "vue" },
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
                        -- schemas = require("schemastore").json.schemas(),
                        validate = { enable = true },
                    },
                },
            },
            roslyn_ls = {
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
                on_attach = function()
                    if vim.g.roslyn_nvim_selected_solution then
                        vim.notify(vim.g.roslyn_nvim_selected_solution)
                    end
                end,
            },
        }

        -- Configure LSP
        ---@type lsp.ClientCapabilities
        local base_capabilities = vim.lsp.protocol.make_client_capabilities()

        -- Folding
        if pcall(require, "ufo") then
            base_capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
        end

        --- @param client vim.lsp.Client
        --- @param bufnr integer
        local default_on_attach = function(client, bufnr)
            local map = function(keys, func, desc, mode)
                vim.keymap.set(mode or "n", keys, func, { buffer = bufnr, desc = "LSP: " .. desc })
            end

            map("<leader>lsr", function()
                vim.notify("Restarting LSP client: " .. client.name)
                vim.cmd("LspRestart " .. client.name)
            end, "Restart")

            map("<leader>ih", function()
                local filter = { bufnr = 0 }
                local enabled = not vim.lsp.inlay_hint.is_enabled(filter)
                vim.lsp.inlay_hint.enable(enabled, filter)
                vim.notify("Inlay Hints: " .. tostring(enabled))
            end, "Inlay Hints")

            map("<leader>h", vim.lsp.buf.document_highlight, "Highlight")

            map("<leader>H", vim.lsp.buf.clear_references, "Unhighlight")
        end

        for server, config in pairs(servers) do
            if config.capabilities then
                config.capabilities = vim.tbl_deep_extend("force", base_capabilities, config.capabilities)
            else
                config.capabilities = base_capabilities
            end

            local custom_on_attach = config.on_attach

            config.on_attach = function(client, bufnr)
                default_on_attach(client, bufnr)

                if custom_on_attach then
                    custom_on_attach(client, bufnr)
                end
            end

            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end
    end,
}
