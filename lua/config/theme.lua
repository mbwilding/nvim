local colors = require("config/colors")

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

local function set_highlights(transparent)
	if transparent then
		-- Transparent
		highlight("Normal", { fg = colors.fg, bg = colors.transparent }) -- Current window
		highlight("NormalNC", { fg = colors.fg, bg = colors.transparent }) -- Non-current window
		highlight("ColorColumn", { fg = colors.fg, bg = colors.transparent }) -- Columns set with `colorcolumn`
	else
		-- Normal
		highlight("Normal", { fg = colors.fg, bg = colors.bg }) -- Current window
		highlight("NormalNC", { fg = colors.fg, bg = colors.bg }) -- Non-current window
		highlight("ColorColumn", { fg = colors.fg, bg = colors.window_bg }) -- Columns set with `colorcolumn`
	end

	-- Theme
	highlight("NormalSB", { fg = colors.fg, bg = colors.error })      -- Normal text in sidebar
	highlight("NormalFloat", { fg = colors.fg, bg = colors.window_bg }) -- Normal text in floating windows
	highlight("LineNr", { fg = colors.fg, bg = colors.transparent })  -- Line numbers
	highlight("CursorLineNr", { fg = colors.fg, bg = colors.window_bg }) -- Line numbers
	highlight("MatchParen", { fg = colors.bg, bg = colors.blue })     -- Matching pair highlight
	highlight("ErrorMsg", { fg = colors.error })                      -- Error messages on the commandline
	highlight("Cursor", { fg = colors.fg, bg = colors.bg })           -- Character under the cursor
	highlight("lCursor", { fg = colors.fg, bg = colors.bg })          -- Character under the cursor when `language-mapping`
	highlight("CursorIM", { fg = colors.fg, bg = colors.bg })         -- Character under the cursor in IME mode
	highlight("CursorLine", { fg = colors.blue, bg = colors.transparent }) -- Screen line at the cursor
	highlight("IncSearch", { fg = colors.bg, bg = colors.blue })      -- Yank highlight
	highlight("Conceal", { fg = colors.redundant, bg = colors.transparent }) -- Yank highlight

	-- Lazy
	highlight("LazyComment", { fg = colors.comment })
	highlight("LazyProp", { fg = colors.blue })
	highlight("LazyReasonPlugin", { fg = colors.comment })
	highlight("LazySpecial", { fg = colors.blue })
	highlight("LazyH1", { fg = colors.bg, bg = colors.blue })
	highlight("LazyButton", { fg = colors.fg, bg = colors.window_accent })
	highlight("LazyButtonActive", { fg = colors.bg, bg = colors.blue })
	highlight("Title", { fg = colors.blue_light })

	-- Mason
	highlight("MasonHeader", { fg = colors.bg, bg = colors.blue })
	highlight("MasonHighlight", { fg = colors.blue, bg = colors.transparent })
	highlight("MasonHighlightBlockBold", { fg = colors.window_accent, bg = colors.blue })
	highlight("MasonMuted", { fg = colors.redundant, bg = colors.transparent })
	highlight("MasonMutedBlock", { fg = colors.fg, bg = colors.window_accent })
	highlight("MasonHighlightBlock", { fg = colors.blue, bg = colors.window_accent })

	-- Oil
	highlight("Directory", { fg = colors.blue })
	highlight("OilFile", { fg = colors.fg })

	-- Code
	highlight("@boolean", { fg = colors.keyword })
	highlight("@constant.macro", { fg = colors.macro })
	highlight("@constant", { fg = colors.constant })
	highlight("@function.macro", { fg = colors.macro })
	highlight("@lsp.mod.declaration", { fg = colors.module })
	highlight("@lsp.mod.library", { fg = colors.module })
	highlight("@lsp.mod.static", { fg = colors.constant })
	highlight("@lsp.type.invalidEscapeSequence", { fg = colors.error })
	highlight("@lsp.type.keyword", { fg = colors.keyword })
	highlight("@lsp.typemod.decorator.attribute", { fg = colors.attribute })
	highlight("@lsp.typemod.derive", { fg = colors.interface })
	highlight("@lsp.typemod.enum", { fg = colors.enum })
	highlight("@lsp.typemod.enumMember", { fg = colors.constant })
	highlight("@lsp.typemod.function", { fg = colors.method })
	highlight("@lsp.typemod.interface.library", { fg = colors.interface })
	highlight("@lsp.typemod.macro", { fg = colors.macro })
	highlight("@lsp.typemod.method", { fg = colors.method })
	highlight("@lsp.typemod.operator.controlFlow", { fg = colors.keyword })
	highlight("@lsp.typemod.property.declaration", { fg = colors.member })
	highlight("@lsp.typemod.property", { fg = colors.member })
	highlight("@lsp.typemod.struct", { fg = colors.struct })
	--highlight("@lsp.typemod.typeAlias.library", { colors.struct }) -- link = "Type"
	highlight("@lsp.typemod.variable", { fg = colors.variable })
	highlight("@module", { fg = colors.namespace })
	highlight("@string.escape", { fg = colors.escape })
	highlight("@variable", { fg = colors.variable })
	highlight("@variable.member", { fg = colors.member })
	highlight("Comment", { fg = colors.comment })
	highlight("Delimiter", { fg = colors.delimiter })
	highlight("Function", { fg = colors.method })
	highlight("Identifier", { fg = colors.member })
	highlight("Number", { fg = colors.number })
	highlight("Operator", { fg = colors.operator })
	highlight("Special", { fg = colors.keyword })
	highlight("Statement", { fg = colors.keyword })
	highlight("String", { fg = colors.string })
	highlight("Type", { fg = colors.struct })

	-- Diagnostics
	highlight("DiagnosticUnnecessary", { fg = colors.redundant })

	-- nvim-notify
	highlight("NotifyBackground", { bg = colors.bg })
	highlight("NotifyINFOBody", { fg = colors.fg })
	highlight("NoiceAttr", { fg = colors.fg })

	-- Hints
	highlight("LspInlayHint", { fg = colors.hint })
	highlight("LspLens", { fg = colors.redundant })

	-- Rust
	highlight("@type.qualifier.rust", { fg = colors.keyword, style = "underline" })
	highlight("@lsp.mod.mutable", { style = "underline" })
	--highlight("@lsp.typemod.namespace.crateRoot", { colors.namespace }) -- link = "@module"
	highlight("@lsp.typemod.interface.declaration", { fg = colors.interface })

	-- CSharp
	highlight("@lsp.type.stringEscapeCharacter.cs", { fg = colors.escape })
end

set_highlights(false)

return colors
