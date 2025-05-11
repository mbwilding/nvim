local servers = {
    zls = {},
    clangd = {},
    gopls = {},
    html = {},
    azure_pipelines_ls = {},
    docker_compose_language_service = {},
    dockerls = {},
    vuels = {},
    taplo = {},
    sqls = {},
    pylsp = {},
    jsonls = {},
    roslyn_ls = {},
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
        bundle_path = os.getenv("HOME") .. "/.lsp/powershell_es",
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
}

for server, config in pairs(servers) do
    config.capabilities = require("blink.cmp").get_lsp_capabilities()

    -- UFO (Folding)
    if pcall(require, "ufo") then
        config.capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
    end

    vim.lsp.config(server, config)
end
vim.lsp.enable(vim.tbl_keys(servers))
