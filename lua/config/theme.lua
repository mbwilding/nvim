local M = {}
local colors = require("config.colors")
local base = colors.base
local code = colors.code

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

function M.toggleTransparency()
	isTransparent = not isTransparent
	M.Highlights(isTransparent, true)
	saveState(isTransparent)
end

function M.Highlights(transparent, toggle)
	if transparent then
		-- Transparent
		highlight("Normal", { fg = base.fg, bg = base.transparent }) -- Current window
		highlight("NormalNC", { fg = base.fg, bg = base.transparent }) -- Non-current window
		highlight("ColorColumn", { fg = base.fg, bg = base.transparent }) -- Columns set with `colorcolumn`
	else
		-- Normal
		highlight("Normal", { fg = base.fg, bg = base.bg }) -- Current window
		highlight("NormalNC", { fg = base.fg, bg = base.bg }) -- Non-current window
		highlight("ColorColumn", { fg = base.fg, bg = base.window_bg }) -- Columns set with `colorcolumn`
	end

	if toggle then
		return
	end

	-- Theme
	highlight("NormalSB", { fg = base.fg, bg = base.transparent }) -- Normal text in sidebar
	highlight("NormalFloat", { fg = base.fg, bg = base.window_bg }) -- Normal text in floating windows

	-- Gutter
	highlight("LineNr", { fg = base.orange, bg = base.transparent })     -- Current line number
	highlight("CursorLineNr", { fg = base.orange, bg = base.transparent }) -- Unknown
	highlight("LineNrAbove", { fg = code.redundant, bg = base.transparent }) -- Above current line numbers
	highlight("LineNrBelow", { fg = code.redundant, bg = base.transparent }) -- Below current line numbers

	highlight("MatchParen", { fg = base.bg, bg = base.blue })            -- Matching pair highlight
	highlight("Cursor", { fg = base.fg, bg = base.orange })              -- Character under the cursor
	highlight("lCursor", { fg = base.fg, bg = base.orange })             -- Character under the cursor when `language-mapping`
	highlight("CursorIM", { fg = base.fg, bg = base.bg })                -- Character under the cursor in IME mode
	highlight("CursorLine", { fg = base.blue, bg = base.transparent })   -- Screen line at the cursor
	highlight("IncSearch", { fg = base.bg, bg = base.blue })             -- Yank highlight
	highlight("Conceal", { fg = code.redundant, bg = base.transparent }) -- Grayed out
	highlight("EndOfBuffer", { fg = base.bg })                           -- End of buffer `~`
	highlight("DiffAdd", { fg = base.green })                            -- Diff add
	highlight("DiffChange", { fg = base.blue_light })                    -- Diff change
	highlight("DiffDelete", { fg = code.error })                         -- Diff delete
	highlight("ErrorMsg", { fg = code.error })                           -- Error messages on the commandline
	highlight("VertSplit", { fg = base.window_accent, bg = base.window_bg }) -- Vertical split border
	highlight("WinSeparator", { fg = base.window_accent, bg = base.window_bg }) -- Window border
	highlight("Folded", { fg = base.blue_light, bg = base.transparent }) -- Folded gutter
	-- Lazy
	highlight("LazyComment", { fg = code.comment })
	highlight("LazyProp", { fg = base.blue })
	highlight("LazyReasonPlugin", { fg = code.comment })
	highlight("LazySpecial", { fg = base.blue })
	highlight("LazyH1", { fg = base.bg, bg = base.blue })
	highlight("LazyButton", { fg = base.fg, bg = base.window_accent })
	highlight("LazyButtonActive", { fg = base.bg, bg = base.blue })
	highlight("Title", { fg = base.blue_light })

	-- Mason
	highlight("MasonHeader", { fg = base.bg, bg = base.blue })
	highlight("MasonHighlight", { fg = base.blue, bg = base.transparent })
	highlight("MasonHighlightBlockBold", { fg = base.window_accent, bg = base.blue })
	highlight("MasonMuted", { fg = code.redundant, bg = base.transparent })
	highlight("MasonMutedBlock", { fg = base.fg, bg = base.window_accent })
	highlight("MasonHighlightBlock", { fg = base.blue, bg = base.window_accent })

	-- File system
	highlight("Directory", { fg = base.blue }) -- Directory color
	highlight("OilFile", { fg = base.orange }) -- Oil file color

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
	highlight("LspInlayHint", { fg = code.hint })
	highlight("LspLens", { fg = code.redundant })

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
	end
})

M.Highlights(isTransparent, false)

return M
