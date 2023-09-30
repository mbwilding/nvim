-- Set main base theme
vim.cmd[[colorscheme tokyonight-night]]

-- Override: Rider Dark Theme
local colors = {
    bg = "#1e1f22",
    fg = "#bdbdbd",
    string = "#c9a26d",
    number = "#ed94c0",
    comment = "#85c46c",
    keywords = "#6c95eb",
    operators = "#bdbdbd",
    type_classes = "#c191ff",
    type_interfaces = "#9591ff",
    instance_method = "#39cc8f",
    constant = "#66c3cc",
    todo = "#66c3cc",
    valid_string_escape = "#d688d4",
    invalid_string_escape = "#ff5647",
    selection = "#08335e",
    labels = "#f0f0f0",
    annotations = "#909090",
    error_hint = "#ff5647"
}

local syntax_map = {
    -- Standard Highlight Groups
    Comment = {fg = colors.comment},
    Constant = {fg = colors.constant},
    String = {fg = colors.string},
    Character = {fg = colors.string},
    Number = {fg = colors.number},
    Boolean = {fg = colors.keywords},
    Float = {fg = colors.number},
    Identifier = {fg = colors.fg},
    Function = {fg = colors.instance_method},
    Statement = {fg = colors.keywords},
    Conditional = {fg = colors.keywords},
    Repeat = {fg = colors.keywords},
    Label = {fg = colors.labels},
    Operator = {fg = colors.operators},
    Keyword = {fg = colors.keywords},
    Exception = {fg = colors.type_interfaces},
    PreProc = {fg = colors.annotations},
    Include = {fg = colors.annotations},
    Define = {fg = colors.annotations},
    Macro = {fg = colors.annotations},
    PreCondit = {fg = colors.annotations},
    Type = {fg = colors.type_classes},
    StorageClass = {fg = colors.keywords},
    Structure = {fg = colors.type_classes},
    Typedef = {fg = colors.keywords},
    Special = {fg = colors.valid_string_escape},
    SpecialChar = {fg = colors.fg},
    Tag = {fg = colors.fg},
    Delimiter = {fg = colors.fg},
    SpecialComment = {fg = colors.fg},
    Debug = {fg = colors.fg},
    Underlined = {fg = colors.fg},
    Ignore = {fg = colors.fg},
    Error = {fg = colors.error_hint},
    Todo = {fg = colors.todo},
    MatchParen = {fg = colors.fg},
    SpecialKey = {fg = colors.fg},
    Title = {fg = colors.comment},
    WildMenu = {fg = colors.fg},

    -- TreeSitter Generic
    TSAnnotation = {fg = colors.annotations},
    TSAttribute = {fg = colors.annotations}, -- Check
    TSBoolean = {fg = colors.keywords},
    TSCharacter = {fg = colors.string},
    TSCharacterSpecial = {fg = colors.valid_string_escape},
    TSComment = {fg = colors.comment},
    TSConditional = {fg = colors.keywords},
    TSConstant = {fg = colors.constant},
    TSConstBuiltin = {fg = colors.constant},
    TSConstMacro = {fg = colors.constant},
    TSConstructor = {fg = colors.instance_method},
    TSDebug = {fg = colors.annotations}, -- Check
    TSDefine = {fg = colors.annotations},
    TSError = {fg = colors.error_hint},
    TSException = {fg = colors.type_interfaces},
    TSField = {fg = colors.instance_method}, -- Check
    TSFloat = {fg = colors.number},
    TSFunction = {fg = colors.instance_method},
    TSFunctionCall = {fg = colors.instance_method}, -- Check
    TSFuncBuiltin = {fg = colors.instance_method},
    TSFuncMacro = {fg = colors.instance_method},
    TSInclude = {fg = colors.annotations},
    TSKeyword = {fg = colors.keywords},
    TSKeywordFunction = {fg = colors.keywords},
    TSKeywordOperator = {fg = colors.operators},
    TSKeywordReturn = {fg = colors.keywords},
    TSLabel = {fg = colors.labels},
    TSMethod = {fg = colors.instance_method},
    TSMethodCall = {fg = colors.instance_method},
    TSNamespace = {fg = colors.type_classes},
    TSNone = {fg = colors.fg},
    TSNumber = {fg = colors.number},
    TSOperator = {fg = colors.operators},
    TSParameter = {fg = colors.instance_method},
    TSParameterReference = {fg = colors.instance_method}, -- Check
    TSPreProc = {fg = colors.annotations},
    TSProperty = {fg = colors.instance_method}, -- Check
    TSPunctDelimiter = {fg = colors.fg},
    TSPunctBracket = {fg = colors.fg},
    TSPunctSpecial = {fg = colors.fg},
    TSRepeat = {fg = colors.keywords},
    TSStorageClass = {fg = colors.keywords},
    TSString = {fg = colors.string},
    TSStringRegex = {fg = colors.string}, -- Check
    TSStringEscape = {fg = colors.valid_string_escape},
    TSStringSpecial = {fg = colors.valid_string_escape}, -- Check
    TSSymbol = {fg = colors.fg}, -- Check
    TSTag = {fg = colors.instance_method}, -- Check
    TSTagAttribute = {fg = colors.annotations}, -- Check
    TSTagDelimiter = {fg = colors.fg}, -- Check
    TSText = {fg = colors.fg},
    TSStrong = {fg = colors.fg}, -- Check
    TSEmphasis = {fg = colors.fg}, -- Check
    TSUnderline = {fg = colors.fg}, -- Check
    TSStrike = {fg = colors.fg}, -- Check
    TSTitle = {fg = colors.comment}, -- Check
    TSLiteral = {fg = colors.string}, -- Check
    TSURI = {fg = colors.string}, -- Check
    TSMath = {fg = colors.number}, -- Check
    TSTextReference = {fg = colors.fg}, -- Check
    TSEnvironment = {fg = colors.annotations}, -- Check
    TSEnvironmentName = {fg = colors.annotations}, -- Check
    TSNote = {fg = colors.todo}, -- Check
    TSWarning = {fg = colors.todo}, -- Check
    TSDanger = {fg = colors.error_hint}, -- Check
    TSTodo = {fg = colors.todo},
    TSType = {fg = colors.type_classes},
    TSTypeBuiltin = {fg = colors.type_classes},
    TSTypeQualifier = {fg = colors.type_classes}, -- Check
    TSTypeDefinition = {fg = colors.type_classes},
    TSVariable = {fg = colors.instance_method},
    TSVariableBuiltin = {fg = colors.instance_method},

    -- TreeSitter GoLang
    goBlock = {fg = colors.fg},
    goBuiltins = {fg = colors.keywords},
    goCharacter = {fg = colors.string},
    goComment = {fg = colors.comment},
    goComplexes = {fg = colors.keywords},
    goConditional = {fg = colors.keywords},
    goConstants = {fg = colors.constant},
    goDecimalInt = {fg = colors.number},
    goDeclType = {fg = colors.keywords},
    goDeclaration = {fg = colors.keywords},
    goDirective = {fg = colors.annotations},
    goEscapeC = {fg = colors.valid_string_escape},
    goEscapeBigU = {fg = colors.valid_string_escape},
    goEscapeError = {fg = colors.valid_string_escape},
    goEscapeOctal = {fg = colors.valid_string_escape},
    goEscapeU = {fg = colors.valid_string_escape},
    goEscapeX = {fg = colors.valid_string_escape},
    goExtraType = {fg = colors.fg},
    goFloat = {fg = colors.number},
    goFloats = {fg = colors.number},
    goFunctionCall = {fg = colors.instance_method},
    goHexadecimalInt = {fg = colors.number},
    goImaginary = {fg = colors.number},
    goLabel = {fg = colors.labels},
    goOctalError = {fg = colors.fg, colors.error_hint},
    goOctalInt = {fg = colors.number},
    goParen = {fg = colors.fg},
    goRawString = {fg = colors.string},
    goRepeat = {fg = colors.keywords},
    goSignedInts = {fg = colors.number},
    goSpaceError = {fg = colors.fg, colors.error_hint},
    goSpecialString = {fg = colors.valid_string_escape},
    goStatement = {fg = colors.keywords},
    goString = {fg = colors.string},
    goTSComment = {fg = colors.comment},
    goTSFunction = {fg = colors.instance_method},
    goTSInclude = {fg = colors.annotations},
    goTSkeyword = {fg = colors.keywords},
    goTSKeywordFunction = {fg = colors.fg},
    goTSMethod = {fg = colors.instance_method},
    goTSNumber = {fg = colors.number},
    goTSOperator = {fg = colors.operators},
    goTSProperty = {fg = colors.fg},
    goTSPunctBracket = {fg = colors.fg},
    goTSPunctDelimiter = {fg = colors.fg},
    goTSRepeat = {fg = colors.keywords},
    goTSString = {fg = colors.string},
    goTSType = {fg = colors.type_classes},
    goTSTypeBuiltin = {fg = colors.keywords},
    goTSVariable = {fg = colors.fg},
    goTodo = {fg = colors.todo},
    goType = {fg = colors.type_classes}
}

-- Apply the colors to each syntax group.
for group, color in pairs(syntax_map) do
    local fg = color.fg or "NONE"
    local bg = color.bg or "NONE"
    vim.cmd("hi " .. group .. " guifg=" .. fg .. " guibg=" .. bg .. " ctermfg=NONE ctermbg=NONE")
end
