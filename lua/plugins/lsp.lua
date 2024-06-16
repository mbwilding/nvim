return {
	"williamboman/mason-lspconfig.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"neovim/nvim-lspconfig",
		"b0o/schemastore.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		vim.g.OmniSharp_server_use_net6 = 1

		-- These can have more fields like cmd, settings and filetypes
		local servers = {
			bashls = {},
			clangd = {},
			rust_analyzer = {},
			gopls = {},
			mesonlsp = {},
			omnisharp = {
				settings = {
					omnisharp = {
						-- enableAsyncCompletion = true,
						enableDecompilationSupport = true,
						-- enableRoslynAnalyzers = true,
						-- enableEditorConfigSupport = true,
					},
				},
			},
			powershell_es = {
				init_options = {
					enableProfileLoading = false,
				},
			},
			azure_pipelines_ls = {},
			docker_compose_language_service = {},
			dockerls = {},
			tsserver = {},
			taplo = {},
			sqls = {},
			pylsp = {},
			jqls = {},
			jsonls = {},
			typos_lsp = {},
			tailwindcss = {
				settings = {
					tailwindCSS = {
						experimental = {
							classRegex = {
								{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
								{ "cx\\(([^)]*)\\)",  "(?:'|\"|`)([^']*)(?:'|\"|`)" },
							},
						},
					},
				},
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
		}

		require("mason").setup()

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

		-- Global mappings.
		-- See `:help vim.diagnostic.*` for documentation on any of the below functions

		vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic: Open float" })
		vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Diagnostic: Goto previous" })
		vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Diagnostic: Goto next" })
		vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostic: Open list" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
			callback = function(event)
				local client = vim.lsp.get_client_by_id(event.data.client_id)
				-- Function to create mappings
				local function map(keys, func, desc)
					vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				if client and client.name == "omnisharp" then
					map("gd", require('omnisharp_extended').telescope_lsp_definition, "Goto definition")
					map("<leader>D", require('omnisharp_extended').telescope_lsp_type_definition,
						"Type definition")
					map("gr", require('omnisharp_extended').telescope_lsp_references, "Goto references")
					map("gi", require('omnisharp_extended').telescope_lsp_implementation, "Goto implementation")
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
				map("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

				-- Navigation
				vim.api.nvim_set_keymap("n", "<C-p>", "<C-t>", { noremap = true, silent = true })
				vim.api.nvim_set_keymap("n", "<C-n>", ":tag<CR>", { noremap = true, silent = true })

				vim.keymap.set("n", "<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, { noremap = true, silent = true, desc = "LSP: Toggle inlay hints" })
			end,
		})
	end,
}
