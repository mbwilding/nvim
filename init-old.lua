local g = vim.g
local o = vim.o
local opt = vim.opt
local a = vim.api
local k = vim.keymap.set
local l = vim.lsp

g.mapleader = " "
g.maplocalleader = " "
g.have_nerd_font = true

o.number = true
o.relativenumber = false
o.mouse = "a"
o.mousemodel = "extend"
o.showmode = false
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.updatetime = 250
o.signcolumn = "yes"
o.timeoutlen = 300
o.splitright = true
o.splitbelow = true
o.list = true
o.inccommand = "split"
o.cursorline = false
o.scrolloff = 3
o.confirm = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

vim.schedule(function()
    o.clipboard = "unnamedplus"
end)

k("n", "U", "<C-r>", { desc = "Redo" })
k("n", "<Esc>", "<cmd>nohlsearch<CR>")
k("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
k("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

k("n", "<C-h>", "<C-w><C-h>", { desc = "Focus: left" })
k("n", "<C-l>", "<C-w><C-l>", { desc = "Focus: right" })
k("n", "<C-j>", "<C-w><C-j>", { desc = "Focus: down" })
k("n", "<C-k>", "<C-w><C-k>", { desc = "Focus: up" })

a.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight on yank",
    group = a.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        error("Error cloning lazy.nvim:\n" .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
opt.rtp:prepend(lazypath)

require("lazy").setup(
    {
        "tpope/vim-sleuth",
        {
            "lewis6991/gitsigns.nvim",
            opts = {
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
            },
        },
        {
            "folke/which-key.nvim",
            event = "VimEnter",
            opts = {
                delay = 1000,
                icons = {
                    mappings = g.have_nerd_font,
                    keys = g.have_nerd_font and {} or {
                        Up = "<Up> ",
                        Down = "<Down> ",
                        Left = "<Left> ",
                        Right = "<Right> ",
                        C = "<C-…> ",
                        M = "<M-…> ",
                        D = "<D-…> ",
                        S = "<S-…> ",
                        CR = "<CR> ",
                        Esc = "<Esc> ",
                        ScrollWheelDown = "<ScrollWheelDown> ",
                        ScrollWheelUp = "<ScrollWheelUp> ",
                        NL = "<NL> ",
                        BS = "<BS> ",
                        Space = "<Space> ",
                        Tab = "<Tab> ",
                        F1 = "<F1>",
                        F2 = "<F2>",
                        F3 = "<F3>",
                        F4 = "<F4>",
                        F5 = "<F5>",
                        F6 = "<F6>",
                        F7 = "<F7>",
                        F8 = "<F8>",
                        F9 = "<F9>",
                        F10 = "<F10>",
                        F11 = "<F11>",
                        F12 = "<F12>",
                    },
                },

                spec = {
                    { "<leader>s", group = "[S]earch" },
                    { "<leader>t", group = "[T]oggle" },
                    { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
                },
            },
        },
        {
            "nvim-telescope/telescope.nvim",
            event = "VimEnter",
            dependencies = {
                "nvim-lua/plenary.nvim",
                {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    build = "make",
                    cond = function()
                        return vim.fn.executable("make") == 1
                    end,
                },
                { "nvim-telescope/telescope-ui-select.nvim" },
                { "nvim-tree/nvim-web-devicons", enabled = g.have_nerd_font },
            },
            config = function()
                require("telescope").setup({
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_dropdown(),
                        },
                    },
                })

                pcall(require("telescope").load_extension, "fzf")
                pcall(require("telescope").load_extension, "ui-select")

                local builtin = require("telescope.builtin")
                vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
                vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
                vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
                vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
                vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
                vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
                vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
                vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
                vim.keymap.set(
                    "n",
                    "<leader>s.",
                    builtin.oldfiles,
                    { desc = "[S]earch Recent Files (\".\" for repeat)" }
                )
                vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })

                k("n", "<leader>/", function()
                    builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                        winblend = 10,
                        previewer = false,
                    }))
                end, { desc = "[/] Fuzzily search in current buffer" })

                k("n", "<leader>s/", function()
                    builtin.live_grep({
                        grep_open_files = true,
                        prompt_title = "Live Grep in Open Files",
                    })
                end, { desc = "[S]earch [/] in Open Files" })

                k("n", "<leader>sn", function()
                    builtin.find_files({ cwd = vim.fn.stdpath("config") })
                end, { desc = "[S]earch [N]eovim files" })
            end,
        },
        {
            "folke/lazydev.nvim",
            ft = "lua",
            opts = {
                library = {
                    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                },
            },
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { "williamboman/mason.nvim", opts = {} },
                "williamboman/mason-lspconfig.nvim",
                "WhoIsSethDaniel/mason-tool-installer.nvim",
                { "j-hui/fidget.nvim", opts = {} },
                "saghen/blink.cmp",
            },
            config = function()
                a.nvim_create_autocmd("LspAttach", {
                    group = a.nvim_create_augroup("lsp-attach", { clear = true }),
                    callback = function(event)
                        local map = function(keys, func, desc, mode)
                            mode = mode or "n"
                            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
                        end
                        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
                        map("gra", vim.lsp.buf.code_action, "[G]oto Code [A]ction", { "n", "x" })
                        map("grr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
                        map("gri", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
                        map("grd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
                        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
                        map("gO", require("telescope.builtin").lsp_document_symbols, "Open Document Symbols")
                        map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Open Workspace Symbols")
                        map("grt", require("telescope.builtin").lsp_type_definitions, "[G]oto [T]ype Definition")

                        ---@param client vim.lsp.Client
                        ---@param method vim.lsp.protocol.Method
                        ---@param bufnr? integer some lsp support methods only in specific files
                        ---@return boolean
                        local function client_supports_method(client, method, bufnr)
                            if vim.fn.has("nvim-0.11") == 1 then
                                return client:supports_method(method, bufnr)
                            else
                                return client.supports_method(method, { bufnr = bufnr })
                            end
                        end

                        local client = l.get_client_by_id(event.data.client_id)
                        if
                            client
                            and client_supports_method(
                                client,
                                l.protocol.Methods.textDocument_documentHighlight,
                                event.buf
                            )
                        then
                            local highlight_augroup = a.nvim_create_augroup("lsp-highlight", { clear = false })
                            a.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = vim.lsp.buf.document_highlight,
                            })

                            a.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                                buffer = event.buf,
                                group = highlight_augroup,
                                callback = l.buf.clear_references,
                            })

                            a.nvim_create_autocmd("LspDetach", {
                                group = a.nvim_create_augroup("lsp-detach", { clear = true }),
                                callback = function(event2)
                                    l.buf.clear_references()
                                    a.nvim_clear_autocmds({ group = "lsp-highlight", buffer = event2.buf })
                                end,
                            })
                        end

                        if
                            client
                            and client_supports_method(
                                client,
                                vim.lsp.protocol.Methods.textDocument_inlayHint,
                                event.buf
                            )
                        then
                            map("<leader>th", function()
                                l.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
                            end, "[T]oggle Inlay [H]ints")
                        end
                    end,
                })

                vim.diagnostic.config({
                    severity_sort = true,
                    float = { border = "rounded", source = "if_many" },
                    underline = { severity = vim.diagnostic.severity.ERROR },
                    signs = g.have_nerd_font and {
                        text = {
                            [vim.diagnostic.severity.ERROR] = "󰅚 ",
                            [vim.diagnostic.severity.WARN] = "󰀪 ",
                            [vim.diagnostic.severity.INFO] = "󰋽 ",
                            [vim.diagnostic.severity.HINT] = "󰌶 ",
                        },
                    } or {},
                    virtual_text = {
                        source = "if_many",
                        spacing = 2,
                        format = function(diagnostic)
                            local diagnostic_message = {
                                [vim.diagnostic.severity.ERROR] = diagnostic.message,
                                [vim.diagnostic.severity.WARN] = diagnostic.message,
                                [vim.diagnostic.severity.INFO] = diagnostic.message,
                                [vim.diagnostic.severity.HINT] = diagnostic.message,
                            }
                            return diagnostic_message[diagnostic.severity]
                        end,
                    },
                })

                local capabilities = require("blink.cmp").get_lsp_capabilities()

                local servers = {
                    -- clangd = {},
                    -- gopls = {},
                    -- pyright = {},
                    -- rust_analyzer = {},
                    -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
                    --
                    -- Some languages (like typescript) have entire language plugins that can be useful:
                    --    https://github.com/pmizio/typescript-tools.nvim
                    --
                    -- But for many setups, the LSP (`ts_ls`) will work just fine
                    -- ts_ls = {},
                    --

                    lua_ls = {
                        -- cmd = { ... },
                        -- filetypes = { ... },
                        -- capabilities = {},
                        settings = {
                            Lua = {
                                completion = {
                                    callSnippet = "Replace",
                                },
                                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                                -- diagnostics = { disable = { 'missing-fields' } },
                            },
                        },
                    },
                }

                local ensure_installed = vim.tbl_keys(servers or {})
                vim.list_extend(ensure_installed, {
                    "stylua",
                })
                require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

                require("mason-lspconfig").setup({
                    ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
                    automatic_installation = false,
                    handlers = {
                        function(server_name)
                            local server = servers[server_name] or {}
                            -- This handles overriding only values explicitly passed
                            -- by the server configuration above. Useful when disabling
                            -- certain features of an LSP (for example, turning off formatting for ts_ls)
                            server.capabilities =
                                vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
                            require("lspconfig")[server_name].setup(server)
                        end,
                    },
                })
            end,
        },
        {
            "stevearc/conform.nvim",
            event = { "BufWritePre" },
            cmd = { "ConformInfo" },
            keys = {
                {
                    "<leader>f",
                    function()
                        require("conform").format({ async = true, lsp_format = "fallback" })
                    end,
                    mode = "",
                    desc = "[F]ormat buffer",
                },
            },
            opts = {
                notify_on_error = false,
                format_on_save = false,
                formatters_by_ft = {
                    lua = { "stylua" },
                    -- Conform can also run multiple formatters sequentially
                    -- python = { "isort", "black" },
                    --
                    -- You can use 'stop_after_first' to run the first available formatter from the list
                    -- javascript = { "prettierd", "prettier", stop_after_first = true },
                },
            },
        },
        {
            "saghen/blink.cmp",
            event = "VimEnter",
            version = "1.*",
            dependencies = {
                {
                    "L3MON4D3/LuaSnip",
                    version = "2.*",
                    build = (function()
                        -- Build Step is needed for regex support in snippets.
                        -- This step is not supported in many windows environments.
                        -- Remove the below condition to re-enable on windows.
                        if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
                            return
                        end
                        return "make install_jsregexp"
                    end)(),
                    dependencies = {
                        {
                            "rafamadriz/friendly-snippets",
                            config = function()
                                require("luasnip.loaders.from_vscode").lazy_load()
                            end,
                        },
                    },
                    opts = {},
                },
                "folke/lazydev.nvim",
            },
            --- @module 'blink.cmp'
            --- @type blink.cmp.Config
            opts = {
                keymap = {
                    preset = "default",
                },
                appearance = {
                    nerd_font_variant = "mono",
                },
                completion = {
                    documentation = { auto_show = false, auto_show_delay_ms = 500 },
                },
                sources = {
                    default = { "lsp", "path", "snippets", "lazydev" },
                    providers = {
                        lazydev = { module = "lazydev.integrations.blink", score_offset = 100 },
                    },
                },
                snippets = { preset = "luasnip" },
                fuzzy = {
                    implementation = "prefer_rust_with_warning", -- "lua"
                },
                signature = {
                    enabled = true,
                },
            },
        },
        {
            "folke/tokyonight.nvim",
            priority = 1000,
            config = function()
                ---@diagnostic disable-next-line: missing-fields
                require("tokyonight").setup({
                    styles = {
                        comments = {
                            italic = false,
                        },
                    },
                })
                vim.cmd.colorscheme("tokyonight-night")
            end,
        },
        {
            "folke/todo-comments.nvim",
            event = "VimEnter",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = { signs = true },
        },
        {
            "echasnovski/mini.nvim",
            config = function()
                require("mini.ai").setup({ n_lines = 500 })
                require("mini.surround").setup()
                local statusline = require("mini.statusline")
                statusline.setup({ use_icons = g.have_nerd_font })
                ---@diagnostic disable-next-line: duplicate-set-field
                statusline.section_location = function()
                    return "%2l:%-2v"
                end
            end,
        },
        {
            "nvim-treesitter/nvim-treesitter",
            build = ":TSUpdate",
            main = "nvim-treesitter.configs",
            opts = {
                ensure_installed = {
                    "bash",
                    "c",
                    "diff",
                    "html",
                    "lua",
                    "luadoc",
                    "markdown",
                    "markdown_inline",
                    "query",
                    "vim",
                    "vimdoc",
                },
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "ruby" },
                },
                indent = {
                    enable = true,
                },
            },
        },
        -- { import = 'custom.plugins' },
    },
    ---@diagnostic disable-next-line: missing-fields
    {
        ui = {
            icons = g.have_nerd_font and {} or {
                cmd = "⌘",
                config = "🛠",
                event = "📅",
                ft = "📂",
                init = "⚙",
                keys = "🗝",
                plugin = "🔌",
                runtime = "💻",
                require = "🌙",
                source = "📄",
                start = "🚀",
                task = "📌",
                lazy = "💤 ",
            },
        },
    }
)
