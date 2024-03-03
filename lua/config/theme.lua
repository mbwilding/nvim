local M = {}
local c = require("config.colors") -- Adjust the path as necessary

local stateFilePath = vim.fn.stdpath("config") .. "/state/transparent_state"

local function loadTransparentState()
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

local function saveTransparentState(state)
	local file = io.open(stateFilePath, "w")
	if file then
		file:write(state and "true" or "false")
		file:close()
	end
end

local isTransparent = loadTransparentState()

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

function M.toggleHighlights()
	isTransparent = not isTransparent
	M.Highlights(isTransparent)
	saveTransparentState(isTransparent)
end

function M.Highlights(transparent)
	if transparent then
		-- Transparent
		highlight("Normal", { fg = c.fg, bg = c.transparent }) -- Current window
		highlight("NormalNC", { fg = c.fg, bg = c.transparent }) -- Non-current window
		highlight("ColorColumn", { fg = c.fg, bg = c.transparent }) -- Columns set with `colorcolumn`
	else
		-- Normal
		highlight("Normal", { fg = c.fg, bg = c.bg }) -- Current window
		highlight("NormalNC", { fg = c.fg, bg = c.bg }) -- Non-current window
		highlight("ColorColumn", { fg = c.fg, bg = c.window_bg }) -- Columns set with `colorcolumn`
	end

	-- Theme
	highlight("NormalSB", { fg = c.fg, bg = c.error })             -- Normal text in sidebar
	highlight("NormalFloat", { fg = c.fg, bg = c.window_bg })      -- Normal text in floating windows
	highlight("LineNr", { fg = c.fg, bg = c.transparent })         -- Line numbers
	highlight("CursorLineNr", { fg = c.fg, bg = c.window_bg })     -- Line numbers
	highlight("MatchParen", { fg = c.bg, bg = c.blue })            -- Matching pair highlight
	highlight("Cursor", { fg = c.fg, bg = c.bg })                  -- Character under the cursor
	highlight("lCursor", { fg = c.fg, bg = c.bg })                 -- Character under the cursor when `language-mapping`
	highlight("CursorIM", { fg = c.fg, bg = c.bg })                -- Character under the cursor in IME mode
	highlight("CursorLine", { fg = c.blue, bg = c.transparent })   -- Screen line at the cursor
	highlight("IncSearch", { fg = c.bg, bg = c.blue })             -- Yank highlight
	highlight("Conceal", { fg = c.redundant, bg = c.transparent }) -- Grayed out
	highlight("EndOfBuffer", { fg = c.bg })                        -- End of buffer `~`
	highlight("Directory", { fg = c.blue })                        -- Directory color
	highlight("DiffAdd", { fg = c.green })                         -- Diff add
	highlight("DiffChange", { fg = c.blue_light })                 -- Diff change
	highlight("DiffDelete", { fg = c.error })                      -- Diff delete
	highlight("ErrorMsg", { fg = c.error })                        -- Error messages on the commandline
	highlight("VertSplit", { fg = c.window_accent, bg = c.window_bg }) -- Vertical split border
	highlight("WinSeparator", { fg = c.window_accent, bg = c.window_bg }) -- Window border
	highlight("Folded", { fg = c.blue_light, bg = c.transparent }) -- Folded gutter
	-- Lazy
	highlight("LazyComment", { fg = c.comment })
	highlight("LazyProp", { fg = c.blue })
	highlight("LazyReasonPlugin", { fg = c.comment })
	highlight("LazySpecial", { fg = c.blue })
	highlight("LazyH1", { fg = c.bg, bg = c.blue })
	highlight("LazyButton", { fg = c.fg, bg = c.window_accent })
	highlight("LazyButtonActive", { fg = c.bg, bg = c.blue })
	highlight("Title", { fg = c.blue_light })

	-- Mason
	highlight("MasonHeader", { fg = c.bg, bg = c.blue })
	highlight("MasonHighlight", { fg = c.blue, bg = c.transparent })
	highlight("MasonHighlightBlockBold", { fg = c.window_accent, bg = c.blue })
	highlight("MasonMuted", { fg = c.redundant, bg = c.transparent })
	highlight("MasonMutedBlock", { fg = c.fg, bg = c.window_accent })
	highlight("MasonHighlightBlock", { fg = c.blue, bg = c.window_accent })

	-- Oil
	highlight("OilFile", { fg = c.fg })

	-- Code
	highlight("@boolean", { fg = c.keyword })
	highlight("@constant.macro", { fg = c.macro })
	highlight("@constant", { fg = c.constant })
	highlight("@function.macro", { fg = c.macro })
	highlight("@lsp.mod.declaration", { fg = c.module })
	highlight("@lsp.mod.library", { fg = c.module })
	highlight("@lsp.mod.static", { fg = c.constant })
	highlight("@lsp.type.invalidEscapeSequence", { fg = c.error })
	highlight("@lsp.type.keyword", { fg = c.keyword })
	highlight("@lsp.typemod.decorator.attribute", { fg = c.attribute })
	highlight("@lsp.typemod.derive", { fg = c.interface })
	highlight("@lsp.typemod.enum", { fg = c.enum })
	highlight("@lsp.typemod.enumMember", { fg = c.constant })
	highlight("@lsp.typemod.function", { fg = c.method })
	highlight("@lsp.typemod.interface.library", { fg = c.interface })
	highlight("@lsp.typemod.macro", { fg = c.macro })
	highlight("@lsp.typemod.method", { fg = c.method })
	highlight("@lsp.typemod.operator.controlFlow", { fg = c.keyword })
	highlight("@lsp.typemod.property.declaration", { fg = c.member })
	highlight("@lsp.typemod.property", { fg = c.member })
	highlight("@lsp.typemod.struct", { fg = c.struct })
	highlight("@lsp.typemod.typeAlias.library", { fg = c.struct }) -- link = "Type"
	highlight("@lsp.typemod.variable", { fg = c.variable })
	highlight("@module", { fg = c.namespace })
	highlight("@string.escape", { fg = c.escape })
	highlight("@variable", { fg = c.variable })
	highlight("@variable.member", { fg = c.member })
	highlight("Comment", { fg = c.comment })
	highlight("Delimiter", { fg = c.delimiter })
	highlight("Function", { fg = c.method })
	highlight("Identifier", { fg = c.member })
	highlight("Number", { fg = c.number })
	highlight("Operator", { fg = c.operator })
	highlight("Special", { fg = c.keyword })
	highlight("Statement", { fg = c.keyword })
	highlight("String", { fg = c.string })
	highlight("Type", { fg = c.struct })

	-- Diagnostics
	highlight("DiagnosticUnnecessary", { fg = c.redundant })

	-- nvim-notify
	highlight("NotifyBackground", { bg = c.bg })
	highlight("NotifyINFOBody", { fg = c.fg })
	highlight("NoiceAttr", { fg = c.fg })

	-- Hints
	highlight("LspInlayHint", { fg = c.hint })
	highlight("LspLens", { fg = c.redundant })

	-- Rust
	highlight("@type.qualifier.rust", { fg = c.keyword, style = "underline" })
	highlight("@lsp.mod.mutable", { style = "underline" })
	highlight("@lsp.typemod.namespace.crateRoot", { fg = c.namespace }) -- link = "@module"
	highlight("@lsp.typemod.interface.declaration", { fg = c.interface })

	-- CSharp
	highlight("@lsp.type.stringEscapeCharacter.cs", { fg = c.escape })
end

M.Highlights(isTransparent)

return M
