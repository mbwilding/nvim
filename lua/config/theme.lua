local c = {
	bg = "#000000",
	fg = "#ffffff",
	none = "NONE",

	variable = "#c4c294",
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
	field = "#66c3cc", -- unused
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

		-- Only add the style part if it's provided and not equal to "NONE"
		if opts.style and opts.style ~= "NONE" then
			table.insert(parts, "gui=" .. opts.style)
		end

		-- Handle foreground color, including the "NONE" case for transparency
		if opts.fg then
			if opts.fg == "NONE" then
				table.insert(parts, "guifg=NONE")
			else
				table.insert(parts, "guifg=" .. opts.fg)
			end
		end

		-- Handle background color, including the "NONE" case for transparency
		if opts.bg then
			if opts.bg == "NONE" then
				table.insert(parts, "guibg=NONE")
			else
				table.insert(parts, "guibg=" .. opts.bg)
			end
		end

		-- Handle special color, including the "NONE" case for transparency
		if opts.sp then
			if opts.sp == "NONE" then
				table.insert(parts, "guisp=NONE")
			else
				table.insert(parts, "guisp=" .. opts.sp)
			end
		end

		-- Join parts with a space and execute the command
		local cmd = table.concat(parts, " ")
		vim.cmd(cmd)
	end
end



local function set_highlights()
	--highlight("Normal", { fg = colors.fg, bg = colors.bg })
	--highlight("Error", { fg = colors.red, bg = colors.bg, style = "bold" })
	--highlight("Todo", { fg = colors.bg, bg = colors.yellow, style = "bold,italic" })
	--highlight("CursorLine", { bg = "#333840" })
	--highlight("Underlined", { fg = colors.blue, style = "underline" })
	--highlight("Strikethrough", { fg = colors.red, style = "strikethrough" })

	-- Normal
	--highlight("Normal", { fg = colors.fg, bg = colors.bg })
	--highlight("NormalNC", { fg = colors.fg, bg = colors.bg })

	-- Transparent
	highlight("Normal", { fg = c.none, bg = c.none })
	highlight("NormalNC", { fg = c.none, bg = c.none })

	-- Defaults
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
