-- CMP provides autocomplete suggestions in a pop-up menu.

return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        -- Snippet Engine & its associated nvim-cmp source
        {
            "L3MON4D3/LuaSnip",
            build = (function()
                -- Build Step is needed for regex support in snippets
                -- This step is not supported in many windows environments
                -- Remove the below condition to re-enable on windows
                if vim.fn.has("win32") == 1 then
                    return
                end
                return "make install_jsregexp"
            end)(),
        },
        "saadparwaiz1/cmp_luasnip",
        -- Adds LSP completion capabilities
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        -- Adds a number of user-friendly snippets
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim",

        -- "zbirenbaum/icopilot-cmp"
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")
        require("luasnip.loaders.from_vscode").lazy_load()

        -- LuaSnip
        local luasnip = require("luasnip")
        luasnip.config.setup()
        local s = luasnip.snippet
        local sn = luasnip.snippet_node
        local t = luasnip.text_node
        local i = luasnip.insert_node
        local f = luasnip.function_node
        local c = luasnip.choice_node
        local d = luasnip.dynamic_node
        local r = luasnip.restore_node
        luasnip.add_snippets("rust", {
            -- s("struct", {
            --     t({ "#[derive(Debug)]", "struct " }), i(1, "Name"), t({ " {", "\t" }), i(2, "field"), t({ ": "}), i(3, "Type"), t({ "", "}" }),
            -- }),
            s("impl-struct", {
                t({ "impl " }), i(1, "Name"), t({ " {", "\tpub fn new() -> Self {",
                "\t\tSelf {", "\t\t\t" }), i(2, "// init_fields"), t({ "", "\t\t}", "\t}", "}" }),
            }),
        })

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            completion = {
                completeopt = "menu,menuone,noinsert",
            },
            mapping = {
                -- Select the [n]ext item
                ["<C-n>"] = cmp.mapping.select_next_item(),
                -- Select the [p]revious item
                ["<C-p>"] = cmp.mapping.select_prev_item(),

                -- Accept ([y]es) the completion.
                --  This will auto-import if your LSP supports it.
                --  This will expand snippets if the LSP sent a snippet.
                ["<C-y>"] = cmp.mapping.confirm({ select = true }),

                -- Manually trigger a completion from nvim-cmp.
                --  Generally you don't need this, because nvim-cmp will display
                --  completions whenever it has completion options available.
                ["<C-Space>"] = cmp.mapping.complete({}),

                -- Think of <c-l> as moving to the right of your snippet expansion.
                --  So if you have a snippet that's like:
                --  function $name($args)
                --    $body
                --  end
                --
                -- <c-l> will move you to the right of each of the expansion locations.
                -- <c-h> is similar, except moving you backwards.
                ["<C-l>"] = cmp.mapping(function()
                    if luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    end
                end, { "i", "s" }),

                ["<C-h>"] = cmp.mapping(function()
                    if luasnip.locally_jumpable(-1) then
                        luasnip.jump(-1)
                    end
                end, { "i", "s" }),
            },
            sources = {
                { name = "luasnip",  group_index = 1 },
                { name = "nvim_lsp", group_index = 2 },
                { name = "path",     group_index = 3 },
                -- { name = "copilot",  group_index = 4 },
            },
            formatting = {
                format = lspkind.cmp_format({
                    max_width = 50,
                    -- mode = "symbol",
                    -- symbol_map = { Copilot = "" },
                }),
            },
        })
    end,
}
