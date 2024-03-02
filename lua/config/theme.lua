local c = {
	transparent = "NONE",
	fg = "#bdbdbd", -- variable
	bg = "#000000",
	bg_window = "#090909",
	bg_button = "#1f1f1f",
	hl_main = "#4eade5", -- macro
	hl_alt = "#6c95eb", -- keyword

	variable = "#bdbdbd",
	operator = "#bdbdbd",
	string = "#c9a26d",
	number = "#ed94c0",
	escape = "#ed94c0",
	comment = "#85c46c",
	comment_alt = "#487d34",
	keyword = "#6c95eb",
	struct = "#c191ff",
	enum = "#e1bfff",
	interface = "#9591ff",
	method = "#39cc8f",
	constant = "#66c3cc",
	member = "#66c3cc",
	todo = "#66c3cc",
	macro = "#4eade5",
	attribute = "#c191ff",
	error = "#ff0000",
	hint = "#555555",
	redundant = "#787878",
	delimiter = "#cccccc",
	namespace = "#ffb083",
	module = "#ffd3b3",
}

local function highlight(group, opts)
	if opts.link then
		local cmd = string.format("highlight! link %s %s", group, opts.link)
		vim.cmd(cmd)
	else
		local parts = { "highlight", group }

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
end

local function set_highlights()
	-- Normal
	highlight("Normal", { fg = c.fg, bg = c.bg })      -- Current window
	highlight("NormalNC", { fg = c.fg, bg = c.bg })    -- Non-current window
	highlight("ColorColumn", { fg = c.fg, bg = c.bg_window }) -- Columns set with `colorcolumn`

	-- Transparent
	--highlight("Normal", { fg = c.fg, bg = c.transparent }) -- Current window
	--highlight("NormalNC", { fg = c.fg, bg = c.transparent }) -- Non-current window
	--highlight("ColorColumn", { fg = c.fg, bg = c.transparent }) -- Columns set with `colorcolumn`

	-- Theme
	highlight("NormalSB", { fg = c.fg, bg = c.error })  -- Normal text in sidebar
	highlight("NormalFloat", { fg = c.fg, bg = c.bg_window }) -- Normal text in floating windows
	highlight("CursorLineNr", { fg = c.fg, bg = c.bg_window }) -- Line numbers
	highlight("MatchParen", { fg = c.bg, bg = c.hl_main }) -- Matching pair highlight
	highlight("ErrorMsg", { fg = c.error })             -- Error messages on the commandline
	highlight("LineNr", { fg = c.fg, bg = c.bg_window }) -- Line numbers
	highlight("Cursor", { fg = c.fg, bg = c.bg })       -- Character under the cursor
	highlight("lCursor", { fg = c.fg, bg = c.bg })      -- Character under the cursor when `language-mapping`
	highlight("CursorIM", { fg = c.fg, bg = c.bg })     -- Character under the cursor in IME mode
	highlight("CursorLine", { fg = c.fg, bg = c.bg_button }) -- Screen line at the cursor
	highlight("IncSearch", { fg = c.bg, bg = c.hl_main }) -- Yank highlight

	-- Lazy
	highlight("LazyComment", { fg = c.hl_main })          -- Lazy comment
	highlight("LazyReasonPlugin", { fg = c.hl_alt })      -- Lazy status
	highlight("LazySpecial", { fg = c.hl_alt })           -- Lazy icons
	highlight("LazyH1", { fg = c.bg, bg = c.hl_main })    -- Lazy header
	highlight("LazyButtonActive", { fg = c.bg, bg = c.hl_main }) -- Lazy button

	-- Mason
	highlight("MasonHeader", { fg = c.bg, bg = c.hl_main })             -- Mason header
	highlight("MasonHighlight", { fg = c.hl_main, bg = c.transparent }) -- Mason highlight
	highlight("MasonHighlightBlockBold", { fg = c.bg_button, bg = c.hl_main }) -- Mason highlight block bold
	highlight("MasonMuted", { fg = c.redundant, bg = c.transparent })   -- Mason muted
	highlight("MasonMutedBlock", { fg = c.fg, bg = c.bg_button })       -- Mason muted blocked
	highlight("MasonHighlightBlock", { fg = c.hl_main, bg = c.bg_button }) -- Mason muted blocked

	-- Code
	highlight("@variable", { fg = c.variable })
	highlight("String", { fg = c.string })
	highlight("Number", { fg = c.number })
	highlight("Type", { fg = c.struct })
	highlight("Comment", { fg = c.comment })
	highlight("Special", { fg = c.keyword })
	highlight("Statement", { fg = c.keyword })
	highlight("Function", { fg = c.method })
	highlight("Operator", { fg = c.operator })
	highlight("Delimiter", { fg = c.delimiter })
	highlight("@function.macro", { fg = c.macro })
	highlight("@module", { fg = c.namespace })
	highlight("@constant", { fg = c.constant })
	highlight("@lsp.mod.library", { fg = c.module })
	highlight("@lsp.typemod.method", { fg = c.method })
	highlight("@lsp.typemod.macro", { fg = c.macro })
	highlight("@variable.member", { fg = c.member })
	highlight("@lsp.type.keyword", { fg = c.keyword })
	highlight("@lsp.typemod.interface.library", { fg = c.interface })
	highlight("@lsp.typemod.typeAlias.library", { link = "Type" })
	highlight("@lsp.mod.declaration", { fg = c.module })
	highlight("@lsp.typemod.enum", { fg = c.enum })
	highlight("@lsp.typemod.decorator.attribute", { fg = c.attribute })
	highlight("@lsp.typemod.derive", { fg = c.interface })
	highlight("@lsp.typemod.enumMember", { fg = c.constant })
	highlight("@lsp.typemod.function", { fg = c.method })
	highlight("@lsp.typemod.variable", { fg = c.variable })
	highlight("@lsp.typemod.property.declaration", { fg = c.member })
	highlight("@lsp.typemod.struct", { fg = c.struct })
	highlight("@boolean", { fg = c.keyword })
	highlight("@lsp.typemod.property", { fg = c.member })
	highlight("Identifier", { fg = c.member })
	highlight("@string.escape", { fg = c.escape })
	highlight("@lsp.type.invalidEscapeSequence", { fg = c.error })
	highlight("@constant.macro", { fg = c.macro })
	highlight("@lsp.typemod.operator.controlFlow", { fg = c.keyword })

	-- Statuses
	highlight("@WarningMsg", { fg = c.hint })

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
	highlight("@lsp.typemod.namespace.crateRoot", { link = "@module" })
	highlight("@lsp.typemod.interface.declaration", { fg = c.interface })

	-- CSharp
	highlight("@lsp.type.stringEscapeCharacter.cs", { fg = c.escape })
end

set_highlights()
