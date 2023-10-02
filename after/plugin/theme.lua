-- Set main base theme

-- vim.cmd.colorscheme "catppuccin-mocha"
vim.cmd.colorscheme "tokyonight-night"

-- Overrides
local colors = {
    fg = "#bdbdbd",
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

    -- Rust
    crate = "#ffb083",
    module = "#ffd3b3",
}

local syntax_map = {
    -- Transparent background
    ["Normal"] = {},
    ["NormalNC"] = {},
    -- ["VertSplit"] = {},
    -- ["StatusLine"] = {},
    -- ["StatusLineNC"] = {},

    -- Standard Highlight Groups
    ["@variable"] = { fg = colors.fg },
    ["@variable.builtin"] = { fg = colors.keyword },
    ["Constant"] = { fg = colors.constant },
    ["String"] = { fg = colors.string },
    ["Number"] = { fg = colors.number },
    ["Statement"] = { fg = colors.keyword },
    ["Type"] = { fg = colors.class },
    ["@field"] = { fg = colors.field },
    ["Function"] = { fg = colors.method },
    ["PreProc"] = { fg = colors.keyword },
    ["@keyword"] = { fg = colors.keyword },
    ["@operator"] = { fg = colors.fg },
    ["@property"] = { fg = colors.field },
    ["@parameter"] = { fg = colors.fg },
    ["@keyword.function"] = { fg = colors.keyword },
    ["@punctuation.bracket"] = { fg = colors.fg },
    ["@punctuation.delimiter"] = { fg = colors.fg },
    ["Comment"] = { fg = colors.comment },
    ["@lsp.type.interface"] = { fg = colors.interface },
    ["TodoFgtodo"] = { fg = colors.todo },
    ["TodoBgTODO"] = { fg = colors.todo, bg = colors.none },
    ["@type.builtin"] = { fg = colors.keyword },
    ["DiagnosticUnderlineError"] = { fg = colors.error },
    ["DiagnosticUnnecessary"] = { fg = colors.redundant },

    -- C# (Omnisharp)
    ["@namespace.c_sharp"] = { fg = colors.class },
    ["@constant.macro.c_sharp"] = { fg = colors.macro },
    ["@storageclass.c_sharp"] = { fg = colors.keyword },
    ["@attribute.c_sharp"] = { fg = colors.class },
    ["@boolean.c_sharp"] = { fg = colors.keyword },
    ["@lsp.type.namespace.cs"] = { fg = colors.class },
    ["@lsp.type.fieldName.cs"] = { fg = colors.field },
    ["@lsp.type.enum.cs"] = { fg = colors.enum },
    ["@lsp.type.xmlDocCommentName.cs"] = { fg = colors.comment_alt },
    ["@lsp.type.xmlDocCommentAttributeName.cs"] = { fg = colors.comment_alt },

    -- Rust (rust_analyzer)
    ["@namespace.rust"] = { fg = colors.crate },
    ["@lsp.typemod.namespace.crateRoot.rust"] = { fg = colors.crate },
    ["@lsp.mod.library.rust"] = { fg = colors.module },
    ["@lsp.typemod.interface.library.rust"] = { fg = colors.interface },
    ["@lsp.typemod.struct.library.rust"] = { fg = colors.class },
    ["@lsp.typemod.typeAlias.library.rust"] = { fg = colors.class },
    ["@lsp.typemod.macro.library.rust"] = { fg = colors.macro },
    ["@function.macro.rust"] = { fg = colors.macro },
    ["@lsp.typemod.namespace.declaration.rust"] = { fg = colors.module },
    ["@lsp.typemod.builtinAttribute.attribute.rust"] = { fg = colors.class },
    ["@lsp.typemod.attributeBracket.attribute.rust"] = { fg = colors.class },
    ["@lsp.typemod.decorator.attribute.rust"] = { fg = colors.method },
    ["@lsp.typemod.property.library.rust"] = { fg = colors.field },
    ["@lsp.typemod.function.library.rust"] = { fg = colors.method },
    ["@lsp.typemod.method.defaultLibrary.rust"] = { fg = colors.method },
    ["@lsp.typemod.function.defaultLibrary.rust"] = { fg = colors.method },
    ["@lsp.mod.static.rust"] = { fg = colors.method },
    ["@lsp.type.formatSpecifier.rust"] = { fg = colors.number },
    ["@lsp.mod.controlFlow.rust"] = { fg = colors.keyword },
    ["@lsp.typemod.method.library.rust"] = { fg = colors.method },
    ["@lsp.type.namespace.rust"] = { fg = colors.module },
    ["@lsp.typemod.method.static.rust"] = { fg = colors.method },
    ["@boolean.rust"] = { fg = colors.keyword },
    ["@lsp.mod.attribute.rust"] = { fg = colors.field },
    ["@lsp.type.typeParameter.rust"] = { fg = colors.class },
    ["@lsp.type.enum.rust"] = { fg = colors.enum },
    ["@lsp.typemod.decorator.defaultLibrary.rust"] = { fg = colors.class },
    ["@lsp.typemod.decorator.library.rust"] = { fg = colors.method },
    ["@lsp.typemod.derive.attribute.rust"] = { fg = colors.interface },
    ["@lsp.typemod.enum.library.rust"] = { fg = colors.enum },
    ["@lsp.typemod.generic.attribute.rust"] = { fg = colors.module },
    ["@lsp.typemod.function.attribute.rust"] = { fg = colors.method },
    ["@lsp.typemod.deriveHelper.attribute.rust"] = { fg = colors.crate },
}

-- Apply the colors to each syntax group.
for group, color in pairs(syntax_map) do
    local fg = color.fg or "NONE"
    local bg = color.bg or "NONE"
    vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg .. " ctermfg=NONE ctermbg=NONE")
end
