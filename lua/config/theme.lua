local colorSets = {
	rider = {
		transparent = "NONE",
		fg = "#bdbdbd",
		bg = "#000000",
		bg_window = "#090909",
		bg_button = "#1f1f1f",
		hl_main = "#4eade5",
		hl_alt = "#6c95eb",

		variable = "#bdbdbd",
		operator = "#bdbdbd",
		string = "#c9a26d",
		number = "#ed94c0",
		escape = "#ed94c0",
		comment = "#85c46c",
		--comment_alt = "#487d34",
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
		delimiter = "#bdbdbd",
		namespace = "#ffb083",
		module = "#ffd3b3",
	},
	wilding = {
		transparent = "NONE",
		fg = "#bdbdbd",
		bg = "#000000",
		bg_window = "#090909",
		bg_button = "#1f1f1f",
		hl_main = "#4eade5",
		hl_alt = "#4eade5",

		variable = "#bdbdbd",
		operator = "#bdbdbd",
		string = "#c9a26d",
		number = "#ed94c0",
		escape = "#ed94c0",
		comment = "#85c46c",
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
		delimiter = "#999999",
		namespace = "#ffb083",
		module = "#ffd3b3",
	},
	wilding_gpt = {
		transparent = "NONE",
		fg = "#e0e0e0", -- Light gray for general foreground text
		bg = "#000000",
		bg_window = "#2c313c", -- Slightly lighter blue-gray for window backgrounds
		bg_button = "#333842", -- Dark gray for buttons, ensuring readability
		hl_main = "#61afef", -- Bright blue for main highlights, eye-catching
		hl_alt = "#98c379", -- Green for alternate highlights, offering visual variety

		variable = "#e06c75", -- Bold red for variables, stands out
		operator = "#56b6c2", -- Cyan for operators, distinct and clear
		string = "#98c379", -- Green for strings, natural and easy to identify
		number = "#d19a66", -- Orange for numbers, warm and noticeable
		escape = "#c678dd", -- Purple for escapes, visually distinct
		comment = "#7f848e", -- Darker gray for comments, readable but subdued
		keyword = "#c678dd", -- Purple for keywords, highlighting control structures
		struct = "#e5c07b", -- Bold yellow for structs, bright and eye-catching
		enum = "#56b6c2", -- Cyan, similar to operators for enums, for consistency
		interface = "#e06c75", -- Bold red, similar to variables for interfaces, maintaining theme
		method = "#61afef", -- Bright blue, similar to highlights for methods, cohesive
		constant = "#d19a66", -- Orange, similar to numbers for constants, thematic consistency
		member = "#98c379", -- Green, similar to strings for members, harmonious
		todo = "#c678dd", -- Purple, eye-catching for TODOs, ensuring they stand out
		macro = "#e5c07b", -- Bold yellow, unique for macros, drawing attention
		attribute = "#56b6c2", -- Cyan, creating a link to operators and enums for attributes
		error = "#e06c75", -- Bold red for errors, ensuring they are highly visible
		hint = "#61afef", -- Bright blue for hints, consistent with methods and main highlights
		redundant = "#7f848e", -- Darker gray, similar to comments for redundancies, subtly blending
		delimiter = "#e0e0e0", -- Light gray, matching the foreground for coherence
		namespace = "#c678dd", -- Purple, tying back to keywords and TODOs for namespaces
		module = "#e5c07b", -- Bold yellow, echoing structs and macros for modules
	}
}

local function invertHexColor(hex)
	hex = hex:gsub("#", "")
	local r = tonumber(hex:sub(1, 2), 16)
	local g = tonumber(hex:sub(3, 4), 16)
	local b = tonumber(hex:sub(5, 6), 16)
	r = 255 - r
	g = 255 - g
	b = 255 - b
	local invertedHex = string.format("#%02X%02X%02X", r, g, b)
	return invertedHex
end

local function highlight(group, opts, invert)
	if invert then
		if opts.fg and opts.fg ~= "NONE" then
			opts.fg = invertHexColor(opts.fg)
		end
		if opts.bg and opts.bg ~= "NONE" then
			opts.bg = invertHexColor(opts.bg)
		end
	end

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

local function set_highlights(colors, transparent, invert)
	local theme = colorSets[colors]

	if transparent then
		-- Transparent
		highlight("Normal", { fg = theme.fg, bg = theme.transparent }) -- Current window
		highlight("NormalNC", { fg = theme.fg, bg = theme.transparent }) -- Non-current window
		highlight("ColorColumn", { fg = theme.fg, bg = theme.transparent }) -- Columns set with `colorcolumn`
	else
		-- Normal
		highlight("Normal", { fg = theme.fg, bg = theme.bg }) -- Current window
		highlight("NormalNC", { fg = theme.fg, bg = theme.bg }) -- Non-current window
		highlight("ColorColumn", { fg = theme.fg, bg = theme.bg_window }) -- Columns set with `colorcolumn`
	end

	-- Theme
	highlight("NormalSB", { fg = theme.fg, bg = theme.error }, invert)  -- Normal text in sidebar
	highlight("NormalFloat", { fg = theme.fg, bg = theme.bg_window }, invert) -- Normal text in floating windows
	highlight("LineNr", { fg = theme.fg, bg = theme.transparent }, invert) -- Line numbers
	highlight("CursorLineNr", { fg = theme.fg, bg = theme.bg_window }, invert) -- Line numbers
	highlight("MatchParen", { fg = theme.bg, bg = theme.hl_main }, invert) -- Matching pair highlight
	highlight("ErrorMsg", { fg = theme.error }, invert)                 -- Error messages on the commandline
	highlight("Cursor", { fg = theme.fg, bg = theme.bg }, invert)       -- Character under the cursor
	highlight("lCursor", { fg = theme.fg, bg = theme.bg }, invert)      -- Character under the cursor when `language-mapping`
	highlight("CursorIM", { fg = theme.fg, bg = theme.bg }, invert)     -- Character under the cursor in IME mode
	highlight("CursorLine", { fg = theme.fg, bg = theme.bg_button }, invert) -- Screen line at the cursor
	highlight("IncSearch", { fg = theme.bg, bg = theme.hl_main }, invert) -- Yank highlight

	-- Lazy
	highlight("LazyComment", { fg = theme.comment }, invert)
	highlight("LazyReasonPlugin", { fg = theme.comment }, invert)
	highlight("LazySpecial", { fg = theme.hl_alt }, invert)
	highlight("LazyH1", { fg = theme.bg, bg = theme.hl_main }, invert)
	highlight("LazyButton", { fg = theme.fg, bg = theme.bg_button }, invert)
	highlight("LazyButtonActive", { fg = theme.bg, bg = theme.hl_main }, invert)

	-- Mason
	highlight("MasonHeader", { fg = theme.bg, bg = theme.hl_main }, invert)
	highlight("MasonHighlight", { fg = theme.hl_main, bg = theme.transparent }, invert)
	highlight("MasonHighlightBlockBold", { fg = theme.bg_button, bg = theme.hl_main }, invert)
	highlight("MasonMuted", { fg = theme.redundant, bg = theme.transparent }, invert)
	highlight("MasonMutedBlock", { fg = theme.fg, bg = theme.bg_button }, invert)
	highlight("MasonHighlightBlock", { fg = theme.hl_main, bg = theme.bg_button }, invert)

	-- Oil
	highlight("Directory", { fg = theme.comment }, invert)
	highlight("OilFile", { fg = theme.hl_main }, invert)

	-- Code
	highlight("@boolean", { fg = theme.keyword }, invert)
	highlight("@constant.macro", { fg = theme.macro }, invert)
	highlight("@constant", { fg = theme.constant }, invert)
	highlight("@function.macro", { fg = theme.macro }, invert)
	highlight("@lsp.mod.declaration", { fg = theme.module }, invert)
	highlight("@lsp.mod.library", { fg = theme.module }, invert)
	highlight("@lsp.mod.static", { fg = theme.constant }, invert)
	highlight("@lsp.type.invalidEscapeSequence", { fg = theme.error })
	highlight("@lsp.type.keyword", { fg = theme.keyword }, invert)
	highlight("@lsp.typemod.decorator.attribute", { fg = theme.attribute }, invert)
	highlight("@lsp.typemod.derive", { fg = theme.interface }, invert)
	highlight("@lsp.typemod.enum", { fg = theme.enum }, invert)
	highlight("@lsp.typemod.enumMember", { fg = theme.constant }, invert)
	highlight("@lsp.typemod.function", { fg = theme.method }, invert)
	highlight("@lsp.typemod.interface.library", { fg = theme.interface }, invert)
	highlight("@lsp.typemod.macro", { fg = theme.macro }, invert)
	highlight("@lsp.typemod.method", { fg = theme.method }, invert)
	highlight("@lsp.typemod.operator.controlFlow", { fg = theme.keyword }, invert)
	highlight("@lsp.typemod.property.declaration", { fg = theme.member }, invert)
	highlight("@lsp.typemod.property", { fg = theme.member }, invert)
	highlight("@lsp.typemod.struct", { fg = theme.struct }, invert)
	highlight("@lsp.typemod.typeAlias.library", { link = "Type" }, invert)
	highlight("@lsp.typemod.variable", { fg = theme.variable }, invert)
	highlight("@module", { fg = theme.namespace }, invert)
	highlight("@string.escape", { fg = theme.escape }, invert)
	highlight("@variable", { fg = theme.variable }, invert)
	highlight("@variable.member", { fg = theme.member }, invert)
	highlight("Comment", { fg = theme.comment }, invert)
	highlight("Delimiter", { fg = theme.delimiter }, invert)
	highlight("Function", { fg = theme.method }, invert)
	highlight("Identifier", { fg = theme.member }, invert)
	highlight("Number", { fg = theme.number }, invert)
	highlight("Operator", { fg = theme.operator }, invert)
	highlight("Special", { fg = theme.keyword }, invert)
	highlight("Statement", { fg = theme.keyword }, invert)
	highlight("String", { fg = theme.string }, invert)
	highlight("Type", { fg = theme.struct }, invert)

	-- Diagnostics
	highlight("DiagnosticUnnecessary", { fg = theme.redundant })

	-- nvim-notify
	highlight("NotifyBackground", { bg = theme.bg })
	highlight("NotifyINFOBody", { fg = theme.fg })
	highlight("NoiceAttr", { fg = theme.fg })

	-- Hints
	highlight("LspInlayHint", { fg = theme.hint })
	highlight("LspLens", { fg = theme.redundant })

	-- Rust
	highlight("@type.qualifier.rust", { fg = theme.keyword, style = "underline" })
	highlight("@lsp.mod.mutable", { style = "underline" })
	highlight("@lsp.typemod.namespace.crateRoot", { link = "@module" })
	highlight("@lsp.typemod.interface.declaration", { fg = theme.interface })

	-- CSharp
	highlight("@lsp.type.stringEscapeCharacter.cs", { fg = theme.escape })
end

set_highlights("wilding", true, false)
