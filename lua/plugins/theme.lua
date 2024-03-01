return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            style = "night",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            light_style = "day",    -- The theme is used when the background is set to light
            transparent = true,     -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark",            -- style for sidebars, see below
                floats = "dark",              -- style for floating windows
            },
            sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            day_brightness = 0.3,             -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false,             -- dims inactive windows
            lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold
            --- You can override specific color groups to use other groups or a hex color
            --- function will be called with a ColorScheme table
            ---@class colors ColorScheme
            on_colors = function(colors)
                -- Base
                colors.fg = "#bdbdbd"
                colors.string = "#c9a26d"
                colors.number = "#ed94c0"
                -- colors.operator = "#c9a26d"
                colors.comment = "#85c46c"
                colors.comment_alt = "#487d34"
                colors.keyword = "#6c95eb"
                colors.class = "#c191ff"
                colors.enum = "#e1bfff"
                colors.interface = "#9591ff"
                colors.method = "#39cc8f"
                colors.constant = "#66c3cc"
                colors.field = "#66c3cc"
                colors.macro = "#4eade5"
                colors.redundant = "#787878"
                colors.error = "#ff0000"
                colors.hint = "#555555"
                colors.todo = "#66c3cc"

                -- Rust
                colors.crate = "#ffb083"
                colors.module = "#ffd3b3"
            end,
            --- You can override specific highlights to use other groups or a hex color
            --- function will be called with a Highlights and ColorScheme table
            ---@param hl Highlights
            ---@class colors ColorScheme
            on_highlights = function(hl, colors)
                -- Base
                hl["@variable"] = { fg = colors.fg }
                hl["@variable.member"] = { fg = colors.field }
                hl["@variable.parameter"] = { fg = colors.fg }
                hl["@variable.builtin"] = { fg = colors.keyword }
                -- hl["@operator"] = { fg = colors.operator }
                hl.Constant = { fg = colors.constant }
                hl.String = { fg = colors.string }
                hl["@string.escape"] = { fg = colors.number }
                hl.Number = { fg = colors.number }
                hl.Statement = { fg = colors.keyword }
                hl.Type = { fg = colors.class }
                hl["@field"] = { fg = colors.field }
                hl.Function = { fg = colors.method }
                hl.PreProc = { fg = colors.keyword }
                hl["@keyword"] = { fg = colors.keyword }
                hl["@operator"] = { fg = colors.fg }
                hl["@property"] = { fg = colors.field }
                hl["@parameter"] = { fg = colors.fg }
                hl["@keyword.function"] = { fg = colors.keyword }
                hl["@punctuation.bracket"] = { fg = colors.fg }
                hl["@punctuation.delimiter"] = { fg = colors.fg }
                hl.Comment = { fg = colors.comment }
                hl["@lsp.type.interface"] = { fg = colors.interface }
                hl.TodoFgtodo = { fg = colors.todo }
                hl.TodoBgTODO = { fg = colors.todo, bg = colors.none }
                hl["@type.builtin"] = { fg = colors.keyword }
                hl.DiagnosticUnderlineError = { fg = colors.error }
                hl.DiagnosticUnnecessary = { fg = colors.redundant }

                -- Hints
                hl.LspInlayHint = { fg = colors.hint, bg = colors.none }
                hl.LspLens = { fg = colors.redundant, bg = colors.none }

                -- CSharp
                hl["@namespace.c_sharp"] = { fg = colors.class }
                hl["@constant.macro.c_sharp"] = { fg = colors.macro }
                hl["@storageclass.c_sharp"] = { fg = colors.keyword }
                hl["@attribute.c_sharp"] = { fg = colors.class }
                hl["@boolean.c_sharp"] = { fg = colors.keyword }
                hl["@lsp.type.namespace.cs"] = { fg = colors.class }
                hl["@lsp.type.fieldName.cs"] = { fg = colors.field }
                hl["@lsp.type.enum.cs"] = { fg = colors.enum }
                hl["@lsp.type.xmlDocCommentName.cs"] = { fg = colors.comment_alt }
                hl["@lsp.type.xmlDocCommentAttributeName.cs"] = { fg = colors.comment_alt }
                hl["@lsp.type.stringEscapeCharacter.cs"] = { fg = colors.number }

                -- Rust
                --hl["@operator.rust"] = { link = "@operator" }
                hl["@namespace.rust"] = { fg = colors.crate }
                hl["@module.rust"] = { fg = colors.crate }
                hl["@keyword.storage.rust"] = { fg = colors.keyword }
                hl["@lsp.typemod.namespace.crateRoot.rust"] = { fg = colors.crate }
                hl["@lsp.mod.library.rust"] = { fg = colors.module }
                hl["@lsp.typemod.interface.library.rust"] = { fg = colors.interface }
                hl["@lsp.typemod.struct.library.rust"] = { fg = colors.class }
                hl["@lsp.typemod.typeAlias.library.rust"] = { fg = colors.class }
                hl["@lsp.typemod.macro.library.rust"] = { fg = colors.macro }
                hl["@function.macro.rust"] = { fg = colors.macro }
                hl["@lsp.typemod.namespace.declaration.rust"] = { fg = colors.module }
                hl["@lsp.typemod.builtinAttribute.attribute.rust"] = { fg = colors.class }
                hl["@lsp.typemod.attributeBracket.attribute.rust"] = { fg = colors.class }
                hl["@lsp.typemod.decorator.attribute.rust"] = { fg = colors.method }
                hl["@lsp.typemod.property.library.rust"] = { fg = colors.field }
                hl["@lsp.typemod.function.library.rust"] = { fg = colors.method }
                hl["@lsp.typemod.method.defaultLibrary.rust"] = { fg = colors.method }
                hl["@lsp.typemod.function.defaultLibrary.rust"] = { fg = colors.method }
                hl["@lsp.mod.static.rust"] = { fg = colors.method }
                hl["@lsp.type.formatSpecifier.rust"] = { fg = colors.number }
                hl["@lsp.mod.controlFlow.rust"] = { fg = colors.keyword }
                hl["@lsp.typemod.method.library.rust"] = { fg = colors.method }
                hl["@lsp.type.namespace.rust"] = { fg = colors.module }
                hl["@lsp.typemod.method.static.rust"] = { fg = colors.method }
                hl["@boolean.rust"] = { fg = colors.keyword }
                hl["@lsp.mod.attribute.rust"] = { fg = colors.field }
                hl["@lsp.type.typeParameter.rust"] = { fg = colors.class }
                hl["@lsp.type.enum.rust"] = { fg = colors.enum }
                hl["@lsp.typemod.decorator.defaultLibrary.rust"] = { fg = colors.class }
                hl["@lsp.typemod.decorator.library.rust"] = { fg = colors.method }
                hl["@lsp.typemod.derive.attribute.rust"] = { fg = colors.interface }
                hl["@lsp.typemod.enum.library.rust"] = { fg = colors.enum }
                hl["@lsp.typemod.generic.attribute.rust"] = { fg = colors.module }
                hl["@lsp.typemod.function.attribute.rust"] = { fg = colors.method }
                hl["@lsp.typemod.deriveHelper.attribute.rust"] = { fg = colors.crate }
                hl["@lsp.typemod.string.attribute.rust"] = { fg = colors.string }
                hl["@lsp.typemod.struct.defaultLibrary.rust"] = { fg = colors.class }
                hl["@lsp.typemod.enumMember.library.rust"] = { fg = colors.constant }
            end,
        })

        vim.cmd [[colorscheme tokyonight-night]]
    end,
}
