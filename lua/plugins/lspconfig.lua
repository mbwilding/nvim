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
                        -- diagnostics = { disable = { 'missing-fields' } },
                    },
                },
            },
            bashls = {
                filetypes = { "sh", "zsh", "zshrc" },
            },
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
            },
        }

        -- Configure LSP
        ---@type lsp.ClientCapabilities
        local base_capabilities = require("blink.cmp").get_lsp_capabilities(nil, true)

        if pcall(require, "ufo") then
            base_capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
        end

        for server, config in pairs(servers) do
            config.capabilities = base_capabilities
            vim.lsp.config(server, config)
            vim.lsp.enable(server)
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
            callback = function(event)
                if vim.g.roslyn_nvim_selected_solution then
                    vim.notify(vim.g.roslyn_nvim_selected_solution)
                end

                local client = vim.lsp.get_client_by_id(event.data.client_id)
                if not client then
                    return
                end

                local map = function(keys, func, desc, mode)
                    vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                end

                map("<leader>lsr", function()
                    vim.notify("Restarting LSP client: " .. client.name)
                    vim.cmd("LspRestart " .. client.name)
                end, "Restart")

                if not pcall(require, "conform") then
                    map("<leader>f", function()
                        vim.notify("Formatting")
                        vim.lsp.buf.format({ async = true })
                    end, "Format")
                end

                map("<leader>ih", function()
                    local enabled = not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
                    vim.lsp.inlay_hint.enable(enabled)
                    vim.notify("Inlay Hints: " .. tostring(enabled))
                end, "Inlay Hints")

                map("<leader>h", function()
                    vim.lsp.buf.document_highlight()
                end, "Highlight")

                map("<leader>H", function()
                    vim.lsp.buf.clear_references()
                end, "Unhighlight")
            end,
        })
    end,
}
