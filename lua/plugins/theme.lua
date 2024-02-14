return {
    'navarasu/onedark.nvim',
    priority = 1000,
    lazy = false,
    config = function()
        require('onedark').setup {
            -- Main options --
            style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = true,  -- Show/hide background
            term_colors = true, -- Change terminal color as per the selected theme style
            ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

            -- toggle theme style ---
            toggle_style_key = nil, -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
            toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },

            -- Lualine options --
            lualine = {
                transparent = false, -- lualine center bar transparency
            },

            -- Custom Highlights --
            colors = {
                -- Base
                fg = "#bdbdbd",
                -- gray = "#6e6e6e";
                string = "#c9a26d",
                number = "#ed94c0",
                comment = "#85c46c",
                comment_alt = "#487d34",
                keyword = "#6c95eb",
                class = "#c191ff",
                enum = "#e1bfff",
                interface = "#9591ff",
                method = "#39cc8f",
                constant = "#66c3cc",
                field = "#66c3cc",
                todo = "#66c3cc",
                macro = "#4eade5",
                error = "#ff0000",
                redundant = "#787878",
                format = "#B189F5",

                -- Rust
                crate = "#ffb083",
                module = "#ffd3b3",
                lifetime = "#ff9e64",
            },
            highlights = {
                -- Base
                ["@variable"] = { fg = '$fg' },
                ["@punctuation.delimiter"] = { fg = '$fg' },
                ["@punctuation.bracket"] = { fg = '$fg' },
                ["@punctuation.special"] = { fg = '$macro' },
                ["@constant"] = { fg = '$constant' },
                ["@comment"] = { fg = '$comment' },
                ["@string"] = { fg = '$string' },
                ["@boolean"] = { fg = '$keyword' },
                ["@operator"] = { fg = '$fg' },
                ["@type"] = { fg = '$class' },
                ["@function"] = { fg = '$method' },
                ["Function"] = { fg = '$method' },
                ["@lsp.typemod.method.defaultLibrary"] = { fg = '$method' },
                ["@keyword.repeat"] = { fg = '$keyword' },
                ["@type.builtin"] = { fg = '$keyword' },
                ["@variable.member"] = { fg = '$field' },
                ["@number"] = { fg = '$number' },
                ["@number.float"] = { fg = '$number' },
                ["@keyword"] = { fg = '$keyword' },
                ["@keyword.function"] = { fg = '$keyword' },
                ["@keyword.import"] = { fg = '$keyword' },
                ["@keyword.operator"] = { fg = '$keyword' },
                ["@function.macro"] = { fg = '$macro' },
                ["@lsp.type.macro"] = { fg = '$macro' },
                ["@lsp.type.interface"] = { fg = '$interface' },
                ["@lsp.type.keyword"] = { fg = '$keyword' },
                ["@lsp.typemod.variable.static"] = { fg = '$constant' },
                ["@lsp.type.parameter"] = { fg = '$fg' },
                ["@variable.builtin"] = { fg = '$keyword' },
                ["@variable.parameter"] = { fg = '$fg' },
                ["@lsp.type.builtinType"] = { fg = '$keyword' },
                ["@lsp.type.comment"] = { fg = '$comment' },
                ["@lsp.type.enum"] = { fg = '$enum' },
                ["Structure"] = { fg = '$class' },
                ["@lsp.type.method"] = { fg = '$method' },
                ["@constant.builtin"] = { fg = '$constant' },
                ["@lsp.type.enumMember"] = { fg = '$constant' },
                ["@lsp.type.typeParameter"] = { fg = '$class' },
                ["@lsp.type.generic"] = { fg = '$class' },

                -- Rust
                ["@module.rust"] = { fg = '$module' },
                ["@lsp.mod.crateRoot.rust"] = { fg = '$crate' },
                ["@string.rust"] = { fg = '$string' },
                ["@type.qualifier.rust"] = { fg = '$keyword' },
                ["@lsp.typemod.variable.constant.rust"] = { fg = '$constant' },
                ["@lsp.type.formatSpecifier.rust"] = { fg = '$format' },
                ["@lsp.type.decorator.rust"] = { fg = '$macro' },
                ["@lsp.type.derive.rust"] = { fg = '$interface' },
                ["@lsp.type.lifetime.rust"] = { fg = '$lifetime' },
            },

            -- Plugins Config --
            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true,   -- use undercurl instead of underline for diagnostics
                background = true,    -- use background color for virtual text
            },
        }
        require('onedark').load()
    end,
}