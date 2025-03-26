-- Blink is an completion plugin written in Rust

return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
        "rafamadriz/friendly-snippets",
        "kristijanhusak/vim-dadbod-completion",
        "L3MON4D3/LuaSnip",
        -- "giuxtaposition/blink-cmp-copilot",
    },
    version = "*",
    opts = {
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "dadbod" }, -- copilot
            providers = {
                lsp = {
                    name = "lsp",
                    enabled = true,
                    module = "blink.cmp.sources.lsp",
                    score_offset = 5,
                },
                path = {
                    name = "path",
                    enabled = true,
                    module = "blink.cmp.sources.path",
                    score_offset = 4,
                },
                dadbod = {
                    name = "Dadbod",
                    enabled = true,
                    module = "vim_dadbod_completion.blink",
                    score_offset = 3,
                },
                snippets = {
                    name = "snippets",
                    enabled = true,
                    module = "blink.cmp.sources.snippets",
                    score_offset = 2,
                },
                -- copilot = {
                --     name = "copilot",
                --     enabled = true,
                --     module = "blink-cmp-copilot",
                --     score_offset = 1,
                --     async = true,
                --     transform_items = function(_, items)
                --         local CompletionItemKind = require("blink.cmp.types").CompletionItemKind
                --         local kind_idx = #CompletionItemKind + 1
                --         CompletionItemKind[kind_idx] = "Copilot"
                --         for _, item in ipairs(items) do
                --             item.kind = kind_idx
                --         end
                --         return items
                --     end,
                -- },
            },
        },
        keymap = {
            -- set to 'none' to disable the 'default' preset
            preset = "none",

            ["<C-n>"] = { "select_next", "fallback" },
            ["<C-p>"] = { "select_prev", "fallback" },

            -- disable a keymap from the preset
            -- ["<C-e>"] = {},

            -- show with a list of providers
            ["<C-space>"] = {
                function(cmp)
                    cmp.show()
                    -- cmp.show({ providers = { "snippets" } })
                end,
            },

            -- control whether the next command will be run when using a function
            -- ["<C-n>"] = {
            --     function(cmp)
            --         if some_condition then
            --             return
            --         end -- runs the next command
            --         return true -- doesn't run the next command
            --     end,
            --     "select_next",
            -- },
        },
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono",
            kind_icons = {
                Copilot = "",
                Text = "󰉿",
                Method = "󰊕",
                Function = "󰊕",
                Constructor = "󰒓",

                Field = "󰜢",
                Variable = "󰆦",
                Property = "󰖷",

                Class = "󱡠",
                Interface = "󱡠",
                Struct = "󱡠",
                Module = "󰅩",

                Unit = "󰪚",
                Value = "󰦨",
                Enum = "󰦨",
                EnumMember = "󰦨",

                Keyword = "󰻾",
                Constant = "󰏿",

                Snippet = "󱄽",
                Color = "󰏘",
                File = "󰈔",
                Reference = "󰬲",
                Folder = "󰉋",
                Event = "󱐋",
                Operator = "󰪚",
                TypeParameter = "󰬛",
            },
        },
        snippets = {
            preset = "luasnip",
        },
        completion = {
            accept = {
                -- Create an undo point when accepting a completion item
                create_undo_point = true,
                -- Experimental auto-brackets support
                auto_brackets = {
                    -- Whether to auto-insert brackets for functions
                    enabled = true,
                    -- Default brackets to use for unknown languages
                    default_brackets = { "(", ")" },
                    -- Overrides the default blocked filetypes
                    override_brackets_for_filetypes = {},
                    -- Synchronously use the kind of the item to determine if brackets should be added
                    kind_resolution = {
                        enabled = true,
                        blocked_filetypes = { "typescriptreact", "javascriptreact", "vue" },
                    },
                    -- Asynchronously use semantic token to determine if brackets should be added
                    semantic_token_resolution = {
                        enabled = true,
                        blocked_filetypes = {},
                        -- How long to wait for semantic tokens to return before assuming no brackets should be added
                        timeout_ms = 400,
                    },
                },
            },
            ghost_text = {
                enabled = true,
            },
            menu = {
                auto_show = true,
                draw = {
                    columns = {
                        {
                            -- "item_idx",
                            "kind_icon",
                            "kind",
                            "label",
                            "label_description",
                            gap = 1,
                        },
                    },
                    components = {
                        item_idx = {
                            text = function(ctx)
                                return tostring(ctx.idx)
                            end,
                            highlight = "BlinkCmpItemIdx",
                        },
                    },
                    treesitter = { "lsp" },
                },
                border = "single",
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
                window = {
                    border = "single",
                },
            },
        },
        signature = {
            enabled = true,
        },
    },
}
