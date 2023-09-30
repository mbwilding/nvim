-- Set main base theme
vim.cmd[[colorscheme tokyonight-night]]

-- Overrides
local colors = {
    -- bg = "#1e1f22",
    none = "NONE",
    fg = "#bdbdbd",
    string = "#c9a26d",
    number = "#ed94c0",
    comment = "#85c46c",
    comment_alt = "#487D34",
    keyword = "#6c95eb",
    class = "#c191ff",
    enum = "#e1bfff",
    interface = "#9591ff",
    method = "#39cc8f",
    constant = "#66c3cc",
    field = "#66C3CC",
    todo = "#66c3cc",
    valid_string_escape = "#d688d4",
    selection = "#08335e",
    labels = "#f0f0f0",
    unreachable = "#808080",
    macro = "#4eade5",

    -- Rider Dark
    added_lines = "#29421f",
    annotations = "#909090",
    bookmark_icon_bg = "#d9b72b",
    caret = "#f0f0f0",
    caret_row = "#202424",
    deleted_lines = "#bf3428",
    diff_separators_bg = "#686868",
    documentation = "#303030",
    error_hint = "#4a2421",
    folded_text_border = "#404040",
    gutter_bg = "#282828",
    indent_guide = "#404040",
    information_hint = "#303030",
    line_numbers = "#808080",
    line_numbers_on_caret_row = "#808080",
    method_separators = "#404040",
    modified_lines = "#293a5f",

    -- Rust
    crate = "#ffb083",
    module = "#ffd3B3", -- unused
}

local syntax_map = {
    -- Standard Highlight Groups
    ["@variable"] = {fg = colors.fg},
    ["@variable.builtin"] = {fg = colors.keyword},
    ["Constant"] = {fg = colors.constant},
    ["String"] = {fg = colors.string},
    ["Number"] = {fg = colors.number},
    ["Statement"] = {fg = colors.keyword},
    ["Type"] = {fg = colors.class},
    ["Function"] = {fg = colors.method},
    ["PreProc"] = {fg = colors.keyword},
    ["@keyword"] = {fg = colors.keyword},
    ["@operator"] = {fg = colors.fg},
    ["@property"] = {fg = colors.field},
    ["@parameter"] = {fg = colors.fg},
    ["@keyword.function"] = {fg = colors.keyword},
    ["@punctuation.bracket"] = {fg = colors.fg},
    ["@punctuation.delimiter"] = {fg = colors.fg},
    ["Comment"] = {fg = colors.comment},
    ["@lsp.type.interface"] = {fg = colors.interface},
    ["@type.builtin"] = {fg = colors.keyword},
    ["TodoFgtodo"] = {fg = colors.todo},
    ["TodoBgTODO"] = {fg = colors.todo, bg = colors.none},

    -- C# (Omnisharp)
    ["@lsp.type.namespace.cs"] = {fg = colors.class},
    ["@lsp.type.fieldName.cs"] = {fg = colors.field},
    ["@lsp.type.enum.cs"] = {fg = colors.enum},
    ["@lsp.type.xmlDocCommentName.cs"] = {fg = colors.comment_alt},
    ["@lsp.type.xmlDocCommentAttributeName.cs"] = {fg = colors.comment_alt},

    -- Rust (rust_analyser)
    ["@namespace.rust"] = {fg = colors.crate},
    ["@lsp.typemod.namespace.crateRoot.rust"] = {fg = colors.crate},
    ["@lsp.mod.library.rust"] = {fg = colors.module},
    ["@lsp.typemod.interface.library.rust"] = {fg = colors.interface},
    ["@lsp.typemod.struct.library.rust"] = {fg = colors.class},
    ["@lsp.typemod.typeAlias.library.rust"] = {fg = colors.class},
    ["@lsp.typemod.macro.library.rust"] = {fg = colors.macro},
    ["@function.macro.rust"] = {fg = colors.macro},
    ["@lsp.typemod.namespace.declaration.rust"] = {fg = colors.module},
    ["@lsp.typemod.builtinAttribute.attribute.rust"] = {fg = colors.class},
    ["@lsp.typemod.attributeBracket.attribute.rust"] = {fg = colors.class},
    ["@lsp.typemod.decorator.attribute.rust"] = {fg = colors.method},
    ["@lsp.typemod.property.library.rust"] = {fg = colors.field},
    ["@lsp.typemod.function.library.rust"] = {fg = colors.method},
    ["@lsp.typemod.method.defaultLibrary.rust"] = {fg = colors.method},
    ["@lsp.typemod.function.defaultLibrary.rust"] = {fg = colors.method},
    ["@lsp.mod.static.rust"] = {fg = colors.method},
    ["@lsp.type.formatSpecifier.rust"] = {fg = colors.number},
    ["@lsp.mod.controlFlow.rust"] = {fg = colors.keyword},
    ["@lsp.typemod.method.library.rust"] = {fg = colors.method},
    ["@lsp.type.namespace.rust"] = {fg = colors.module},
    ["@lsp.typemod.method.static.rust"] = {fg = colors.method},
    ["@boolean.rust"] = {fg = colors.keyword},
    ["@lsp.mod.attribute.rust"] = {fg = colors.field},
    ["@lsp.type.typeParameter.rust"] = {fg = colors.class},
    ["@lsp.type.enum.rust"] = {fg = colors.enum},
    ["@lsp.typemod.decorator.defaultLibrary.rust"] = {fg = colors.class},
    ["@lsp.typemod.decorator.library.rust"] = {fg = colors.method},
    ["@lsp.typemod.derive.attribute.rust"] = {fg = colors.interface},
}

-- Apply the colors to each syntax group.
for group, color in pairs(syntax_map) do
    local fg = color.fg or "NONE"
    local bg = color.bg or "NONE"
    vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg .. " ctermfg=NONE ctermbg=NONE")
end
