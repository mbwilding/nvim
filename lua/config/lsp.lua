local servers = {
    -- roslyn_ls = {}, -- roslyn.nvim
    azure_pipelines_ls = {},
    clangd = {},
    docker_compose_language_service = {},
    dockerls = {},
    gopls = {},
    html = {},
    jsonls = {},
    pylsp = {},
    sqls = {},
    taplo = {},
    vuels = {},
    zls = {},
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

-- Configure LSP
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

-- LSP on attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then
            return
        end

        -- Set up signature help overloads
        -- if client.server_capabilities.signatureHelpProvider then
        --     ---@diagnostic disable-next-line: missing-fields
        --     require("lsp-overloads").setup(client, {})
        -- end

        local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Format the buffer
        -- map("<leader>f", function()
        --     vim.notify("Formatting")
        --     vim.lsp.buf.format({ async = true })
        -- end, "Format")

        map("<leader>ih", function()
            local enabled = not vim.lsp.inlay_hint.is_enabled()
            vim.lsp.inlay_hint.enable(enabled)
            vim.notify("Inlay Hints: " .. tostring(enabled))
        end, "Toggle [I]nlay [H]ints")

        map("<leader>h", function()
            vim.lsp.buf.document_highlight()
        end, "Highlight")

        map("<leader>H", function()
            vim.lsp.buf.clear_references()
        end, "Unhighlight")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        --
        -- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
        --     local highlight_augroup = augroup("lsp-highlight")
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
