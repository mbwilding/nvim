-- Blink is an completion plugin written in Rust

return {
    "saghen/blink.cmp",
    lazy = false, -- lazy loading handled internally
    -- optional: provides snippets for the snippet source
    dependencies = {
        "rafamadriz/friendly-snippets",
        "L3MON4D3/LuaSnip",
        "kristijanhusak/vim-dadbod-completion",
    },
    version = "v0.*",

    opts = {
        sources = {
            default = { "lsp", "path", "snippets", "buffer", "luasnip", "dadbod" },
            providers = {
                lsp = {
                    name = "lsp",
                    enabled = true,
                    module = "blink.cmp.sources.lsp",
                    score_offset = 1000,
                },
                path = {
                    name = "path",
                    enabled = true,
                    module = "blink.cmp.sources.path",
                    score_offset = 990,
                },
                luasnip = {
                    name = "luasnip",
                    enabled = true,
                    module = "blink.cmp.sources.luasnip",
                    score_offset = 950,
                },
                snippets = {
                    name = "snippets",
                    enabled = true,
                    module = "blink.cmp.sources.snippets",
                    score_offset = 900,
                },
                dadbod = {
                    name = "Dadbod",
                    module = "vim_dadbod_completion.blink",
                    score_offset = 950,
                },
            },
        },
        keymap = {
            preset = "default",
        },
        appearance = {
            use_nvim_cmp_as_default = false,
            nerd_font_variant = "mono"
        },
        snippets = {
            expand = function(snippet)
                require("luasnip").lsp_expand(snippet)
            end,
            active = function(filter)
                if filter and filter.direction then
                    return require("luasnip").jumpable(filter.direction)
                end
                return require("luasnip").in_snippet()
            end,
            jump = function(direction)
                require("luasnip").jump(direction)
            end,
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
                    default_brackets = { '(', ')' },
                    -- Overrides the default blocked filetypes
                    override_brackets_for_filetypes = {},
                    -- Synchronously use the kind of the item to determine if brackets should be added
                    kind_resolution = {
                        enabled = true,
                        blocked_filetypes = { 'typescriptreact', 'javascriptreact', 'vue' },
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
                            gap = 1
                        },
                    },
                    components = {
                        item_idx = {
                            text = function(ctx) return tostring(ctx.idx) end,
                            highlight = "BlinkCmpItemIdx"
                        }
                    }
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 0,
            }
        },
        signature = {
            enabled = true
        },
    },
}
