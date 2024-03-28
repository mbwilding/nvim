local M = {}

local switch = true

vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

M.base = {
	none = "NONE",

	-- Default UI
	fg = "#bdbdbd",
	bg = "#000000",
	window_bg = "#000000",
	window_accent = "#202020",

	-- Colors
	blue_light = "#4eade5",
	blue_dark = "#6c95eb",
	cyan = "#66c3cc",
	red = "#ff3333",
	pink_light = "#e1bfff",
	pink_dark = "#ed94c0",
	green = "#39cc8f",
	purple_light = "#c191ff",
	purple_dark = "#9591ff",
	brown = "#c9a26d",
	lime = "#85c46c",
	gray_light = "#787878",
	gray_dark = "#4f5258",
	orange_light = "#ffd3b3",
	orange_dark = "#ffb083",
}

M.code = {
	variable = M.base.fg,
	operator = M.base.fg,
	string = M.base.brown,
	delimiter = M.base.fg,
	number = M.base.pink_dark,
	escape = M.base.pink_dark,
	comment = M.base.lime,
	keyword = M.base.blue_dark,
	struct = M.base.purple_light,
	enum = M.base.pink_light,
	interface = M.base.purple_dark,
	method = M.base.green,
	constant = M.base.cyan,
	member = M.base.cyan,
	macro = M.base.blue_light,
	attribute = M.base.purple_light,
	namespace = M.base.orange_dark,
	module = M.base.orange_light,
	redundant = M.base.gray_light,
	hint = M.base.grey_dark,
	todo = M.base.blue_light,
	error = M.base.red,
}


if switch then
	local backup = M.base.blue_light
	M.base.blue_light = M.base.orange_dark
	M.base.orange_dark = backup
end

M.mode = {
	n = M.base.blue_light, -- Normal
	i = M.base.orange_dark, -- Insert
	v = M.base.green, -- Visual
	[""] = M.base.blue_dark,
	V = M.base.green,
	c = M.base.orange_dark,
	no = M.base.cyan,
	s = M.base.orange_dark,
	S = M.base.orange_dark,
	[""] = M.base.orange_dark,
	ic = M.base.blue_dark,
	R = M.base.pink_dark,
	Rv = M.base.pink_dark,
	cv = M.base.cyan,
	ce = M.base.cyan,
	r = M.base.cyan,
	rm = M.base.cyan,
	["r?"] = M.base.cyan,
	["!"] = M.base.cyan,
	t = M.base.cyan,
	nt = M.base.cyan,
}

local base = M.base
local code = M.code

local stateFilePath = vim.fn.stdpath("data") .. "/transparent_state"

local function loadState()
	local file = io.open(stateFilePath, "r")
	if file then
		local state = file:read("*l")
		file:close()
		if state == "true" then
			return true
		end
	end
	return false
end

local function saveState(state)
	local file = io.open(stateFilePath, "w")
	if file then
		file:write(state and "true" or "false")
		file:close()
	end
end

local isTransparent = loadState()

local function highlight(group, opts)
	local parts = { "highlight", group }

	if opts.link then
		local cmd = string.format("highlight! link %s %s", group, opts.link)
		vim.cmd(cmd)
	end

	if opts.style and opts.style ~= "NONE" then
		table.insert(parts, "gui=" .. opts.style)
	end

	if opts.fg then
		if opts.fg == "NONE" then
			table.insert(parts, "guifg=NONE")
		else
			table.insert(parts, "guifg=" .. opts.fg)
		end
	end

	if opts.bg then
		if opts.bg == "NONE" then
			table.insert(parts, "guibg=NONE")
		else
			table.insert(parts, "guibg=" .. opts.bg)
		end
	end

	if opts.sp then
		if opts.sp == "NONE" then
			table.insert(parts, "guisp=NONE")
		else
			table.insert(parts, "guisp=" .. opts.sp)
		end
	end

	local cmd = table.concat(parts, " ")
	vim.cmd(cmd)
end

function M.Highlights(transparent, initialize)
	if transparent then
		-- Transparent
		highlight("Normal", { fg = base.fg, bg = base.none }) -- Current window
		highlight("NormalNC", { fg = base.fg, bg = base.none }) -- Non-current window
		highlight("ColorColumn", { fg = base.fg, bg = base.none }) -- Columns set with `colorcolumn`
		highlight("NormalFloat", { fg = base.fg, bg = base.none }) -- Normal text in floating windows
		-- M.base.window_bg = M.base.none
	else
		-- Normal
		highlight("Normal", { fg = base.fg, bg = base.bg }) -- Current window
		highlight("NormalNC", { fg = base.fg, bg = base.bg }) -- Non-current window
		highlight("ColorColumn", { fg = base.fg, bg = base.window_bg }) -- Columns set with `colorcolumn`
		highlight("NormalFloat", { fg = base.fg, bg = base.window_bg }) -- Normal text in floating windows
	end

	if not initialize then
		return
	end

	-- Theme
	highlight("NormalSB", { fg = base.fg, bg = base.none }) -- Normal text in sidebar

	-- Gutter
	highlight("LineNr", { fg = base.blue_light, bg = base.none }) -- Current line number
	highlight("CursorLineNr", { fg = base.orange_dark, bg = base.none }) -- Unknown
	highlight("LineNrAbove", { fg = code.redundant, bg = base.none }) -- Above current line numbers
	highlight("LineNrBelow", { fg = code.redundant, bg = base.none }) -- Below current line numbers

	-- Generic
	highlight("MatchParen", { fg = base.bg, bg = base.blue_dark })       -- Matching pair highlight
	highlight("Cursor", { fg = base.fg, bg = base.orange_dark })         -- Character under the cursor
	highlight("lCursor", { fg = base.fg, bg = base.orange_dark })        -- Character under the cursor when `language-mapping`
	highlight("CursorIM", { fg = base.fg, bg = base.bg })                -- Character under the cursor in IME mode
	highlight("CursorLine", { fg = base.blue_dark, bg = base.none })     -- Screen line at the cursor
	highlight("IncSearch", { fg = base.bg, bg = base.blue_dark })        -- Yank highlight
	highlight("Conceal", { fg = code.redundant, bg = base.none })        -- Grayed out
	highlight("EndOfBuffer", { fg = base.bg })                           -- End of buffer `~`
	highlight("DiffAdd", { fg = base.green })                            -- Diff add
	highlight("DiffChange", { fg = base.orange_dark })                   -- Diff change
	highlight("DiffDelete", { fg = code.error })                         -- Diff delete
	highlight("ErrorMsg", { fg = code.error })                           -- Error messages on the commandline
	highlight("VertSplit", { fg = base.window_accent, bg = base.window_bg }) -- Vertical split border
	highlight("WinSeparator", { fg = base.window_accent, bg = base.window_bg }) -- Window border
	highlight("WinBar", { fg = base.fg, bg = base.window_bg })
	highlight("WinBarNC", { fg = base.fg, bg = base.window_bg })
	highlight("StatusLine", { fg = base.fg, bg = base.none })
	highlight("StatusLineNC", { fg = base.fg, bg = base.none })
	highlight("Folded", { fg = base.blue_dark, bg = base.none }) -- Folded gutter
	highlight("TabLine", { fg = base.fg, bg = base.window_accent })
	highlight("TabLineSel", { fg = base.window_bg, bg = base.blue_dark })
	highlight("TabLineFill", { bg = base.bg })

	-- NeoVim
	highlight("healthError", { fg = base.red })
	highlight("healthSuccess", { fg = base.green })
	highlight("healthWarning", { fg = base.orange_light })

	-- Cmp
	highlight("CmpDocumentation", { fg = base.fg, bg = base.window_bg })
	highlight("CmpDocumentationBorder", { fg = base.window_accent, bg = base.window_bg })
	highlight("CmpItemAbbr", { fg = base.fg, bg = base.none })
	highlight("CmpItemAbbrDeprecated", { fg = base.gray_dark, bg = base.none, style = "strikethrough" })
	highlight("CmpItemAbbrMatch", { fg = base.blue_light, bg = base.none })
	highlight("CmpItemAbbrMatchFuzzy", { fg = base.blue_light, bg = base.none })

	-- Lazy
	highlight("LazyComment", { fg = code.comment })
	highlight("LazyProp", { fg = base.orange_dark })
	highlight("LazyReasonPlugin", { fg = code.comment })
	highlight("LazySpecial", { fg = base.orange_dark })
	highlight("LazyH1", { fg = base.bg, bg = base.orange_dark })
	highlight("LazyButton", { fg = base.fg, bg = base.window_accent })
	highlight("LazyButtonActive", { fg = base.bg, bg = base.orange_dark })
	highlight("Title", { fg = base.orange_dark })

	-- Mason
	highlight("MasonHeader", { fg = base.bg, bg = base.orange_dark })
	highlight("MasonHighlight", { fg = base.blue_dark, bg = base.none })
	highlight("MasonHighlightBlockBold", { fg = base.window_accent, bg = base.orange_dark })
	highlight("MasonMuted", { fg = code.redundant, bg = base.none })
	highlight("MasonMutedBlock", { fg = base.fg, bg = base.window_accent })
	highlight("MasonHighlightBlock", { fg = base.orange_dark, bg = base.window_accent })

	-- File System
	highlight("Directory", { fg = base.blue_dark }) -- Directory color
	highlight("OilFile", { fg = base.orange_dark }) -- Oil file color

	-- Telescope
	highlight("TelescopeNormal", { fg = base.blue_light, bg = base.window_bg })
	highlight("TelescopeBorder", { fg = base.orange_dark, bg = base.window_bg })
	highlight("TelescopeMatching", { fg = base.orange_dark, bg = base.window_bg })

	-- Which Key
	highlight("WhichKey", { fg = base.orange_dark })
	highlight("WhichKeyGroup", { fg = base.orange_dark })
	highlight("WhichKeyDesc", { fg = base.orange_dark })
	highlight("WhichKeySeparator", { fg = base.orange_dark })
	highlight("WhichKeyFloat", { bg = base.window_bg })
	highlight("WhichKeyValue", { fg = base.orange_dark })

	-- Code
	highlight("@boolean", { fg = code.keyword })
	highlight("@constant.macro", { fg = code.macro })
	highlight("@constant", { fg = code.constant })
	highlight("@function.macro", { fg = code.macro })
	highlight("@lsp.mod.declaration", { fg = code.module })
	highlight("@lsp.mod.library", { fg = code.module })
	highlight("@lsp.mod.static", { fg = code.constant })
	highlight("@lsp.type.invalidEscapeSequence", { fg = code.error })
	highlight("@lsp.type.formatSpecifier", { fg = code.struct })
	highlight("@lsp.type.keyword", { fg = code.keyword })
	highlight("@lsp.typemod.decorator.attribute", { fg = code.attribute })
	highlight("@lsp.typemod.derive", { fg = code.interface })
	highlight("@lsp.typemod.enum", { fg = code.enum })
	highlight("@lsp.typemod.enumMember", { fg = code.constant })
	highlight("@lsp.typemod.function", { fg = code.method })
	highlight("@lsp.typemod.interface.library", { fg = code.interface })
	highlight("@lsp.typemod.macro", { fg = code.macro })
	highlight("@lsp.typemod.method", { fg = code.method })
	highlight("@lsp.typemod.operator.controlFlow", { fg = code.keyword })
	highlight("@lsp.typemod.property.declaration", { fg = code.member })
	highlight("@lsp.typemod.property", { fg = code.member })
	highlight("@lsp.typemod.struct", { fg = code.struct })
	highlight("@lsp.typemod.typeAlias.library", { fg = code.struct }) -- link = "Type"
	highlight("@lsp.typemod.variable", { fg = code.variable })
	highlight("@module", { fg = code.namespace })
	highlight("@string.escape", { fg = code.escape })
	highlight("@variable", { fg = code.variable })
	highlight("@variable.member", { fg = code.member })
	highlight("Comment", { fg = code.comment })
	highlight("Delimiter", { fg = code.delimiter })
	highlight("Function", { fg = code.method })
	highlight("Identifier", { fg = code.member })
	highlight("Number", { fg = code.number })
	highlight("Operator", { fg = code.operator })
	highlight("Special", { fg = code.keyword })
	highlight("Statement", { fg = code.keyword })
	highlight("String", { fg = code.string })
	highlight("Type", { fg = code.struct })

	-- Diagnostics
	highlight("DiagnosticUnnecessary", { fg = code.redundant })

	-- nvim-notify
	highlight("NotifyBackground", { bg = base.bg })
	highlight("NotifyINFOBody", { fg = base.fg })
	highlight("NoiceAttr", { fg = base.fg })

	-- Hints
	highlight("LspInlayHint", { fg = base.gray_dark })
	highlight("LspLens", { fg = base.gray_light })

	-- Rust
	highlight("@type.qualifier.rust", { fg = code.keyword, style = "underline" })
	highlight("@lsp.mod.mutable", { style = "underline" })
	highlight("@lsp.typemod.namespace.crateRoot", { fg = code.namespace }) -- link = "@module"
	highlight("@lsp.typemod.interface.declaration", { fg = code.interface })
	highlight("@lsp.mod.unsafe", { fg = code.error })

	-- CSharp
	highlight("@lsp.type.stringEscapeCharacter.cs", { fg = code.escape })
end

vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*",
	callback = function()
		local colors = require("config/colors")
		local mode = vim.api.nvim_get_mode().mode
		local color = colors.mode[mode] or colors.base.orange

		vim.cmd(string.format("highlight LineNr guifg=%s", color))
		vim.cmd(string.format("highlight Cursor guibg=%s", color))
		vim.cmd(string.format("highlight lCursor guibg=%s", color))

		vim.cmd("set termguicolors")
	end,
})

function M.toggleTransparency()
	isTransparent = not isTransparent
	M.Highlights(isTransparent, false)
	saveState(isTransparent)
end

function M.reload()
	M.Highlights(isTransparent, true)
end

M.Highlights(isTransparent, true)

return M
