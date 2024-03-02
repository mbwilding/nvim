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
	rider_modified = {
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

local theme = colorSets.rider_modified
local transparent = true

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
	if transparent then
		-- Transparent
		highlight("Normal", { fg = theme.fg, bg = theme.transparent }) -- Current window
		highlight("NormalNC", { fg = theme.fg, bg = theme.transparent }) -- Non-current window
		highlight("ColorColumn", { fg = theme.fg, bg = theme.transparent }) -- Columns set with `colorcolumn`
		highlight("LineNr", { fg = theme.fg, bg = theme.transparent }) -- Line numbers
	else
		-- Normal
		highlight("Normal", { fg = theme.fg, bg = theme.bg }) -- Current window
		highlight("NormalNC", { fg = theme.fg, bg = theme.bg }) -- Non-current window
		highlight("ColorColumn", { fg = theme.fg, bg = theme.bg_window }) -- Columns set with `colorcolumn`
		highlight("LineNr", { fg = theme.fg, bg = theme.bg_window }) -- Line numbers
	end

	-- Theme
	highlight("NormalSB", { fg = theme.fg, bg = theme.error })  -- Normal text in sidebar
	highlight("NormalFloat", { fg = theme.fg, bg = theme.bg_window }) -- Normal text in floating windows
	highlight("CursorLineNr", { fg = theme.fg, bg = theme.bg_window }) -- Line numbers
	highlight("MatchParen", { fg = theme.bg, bg = theme.hl_main }) -- Matching pair highlight
	highlight("ErrorMsg", { fg = theme.error })                 -- Error messages on the commandline
	highlight("Cursor", { fg = theme.fg, bg = theme.bg })       -- Character under the cursor
	highlight("lCursor", { fg = theme.fg, bg = theme.bg })      -- Character under the cursor when `language-mapping`
	highlight("CursorIM", { fg = theme.fg, bg = theme.bg })     -- Character under the cursor in IME mode
	highlight("CursorLine", { fg = theme.fg, bg = theme.bg_button }) -- Screen line at the cursor
	highlight("IncSearch", { fg = theme.bg, bg = theme.hl_main }) -- Yank highlight

	-- Lazy
	highlight("LazyComment", { fg = theme.comment })              -- Lazy comment
	highlight("LazyReasonPlugin", { fg = theme.comment })         -- Lazy status
	highlight("LazySpecial", { fg = theme.hl_alt })               -- Lazy icons
	highlight("LazyH1", { fg = theme.bg, bg = theme.hl_main })    -- Lazy header
	highlight("LazyButton", { fg = theme.fg, bg = theme.bg_button }) -- Lazy button
	highlight("LazyButtonActive", { fg = theme.bg, bg = theme.hl_main }) -- Lazy button

	-- Mason
	highlight("MasonHeader", { fg = theme.bg, bg = theme.hl_main })             -- Mason header
	highlight("MasonHighlight", { fg = theme.hl_main, bg = theme.transparent }) -- Mason highlight
	highlight("MasonHighlightBlockBold", { fg = theme.bg_button, bg = theme.hl_main }) -- Mason highlight block bold
	highlight("MasonMuted", { fg = theme.redundant, bg = theme.transparent })   -- Mason muted
	highlight("MasonMutedBlock", { fg = theme.fg, bg = theme.bg_button })       -- Mason muted blocked
	highlight("MasonHighlightBlock", { fg = theme.hl_main, bg = theme.bg_button }) -- Mason muted blocked

	-- Code
	highlight("@variable", { fg = theme.variable })
	highlight("String", { fg = theme.string })
	highlight("Number", { fg = theme.number })
	highlight("Type", { fg = theme.struct })
	highlight("Comment", { fg = theme.comment })
	highlight("Special", { fg = theme.keyword })
	highlight("Statement", { fg = theme.keyword })
	highlight("Function", { fg = theme.method })
	highlight("Operator", { fg = theme.operator })
	highlight("Delimiter", { fg = theme.delimiter })
	highlight("@function.macro", { fg = theme.macro })
	highlight("@module", { fg = theme.namespace })
	highlight("@constant", { fg = theme.constant })
	highlight("@lsp.mod.library", { fg = theme.module })
	highlight("@lsp.typemod.method", { fg = theme.method })
	highlight("@lsp.typemod.macro", { fg = theme.macro })
	highlight("@variable.member", { fg = theme.member })
	highlight("@lsp.type.keyword", { fg = theme.keyword })
	highlight("@lsp.typemod.interface.library", { fg = theme.interface })
	highlight("@lsp.typemod.typeAlias.library", { link = "Type" })
	highlight("@lsp.mod.declaration", { fg = theme.module })
	highlight("@lsp.typemod.enum", { fg = theme.enum })
	highlight("@lsp.typemod.decorator.attribute", { fg = theme.attribute })
	highlight("@lsp.typemod.derive", { fg = theme.interface })
	highlight("@lsp.typemod.enumMember", { fg = theme.constant })
	highlight("@lsp.typemod.function", { fg = theme.method })
	highlight("@lsp.typemod.variable", { fg = theme.variable })
	highlight("@lsp.typemod.property.declaration", { fg = theme.member })
	highlight("@lsp.typemod.struct", { fg = theme.struct })
	highlight("@boolean", { fg = theme.keyword })
	highlight("@lsp.typemod.property", { fg = theme.member })
	highlight("Identifier", { fg = theme.member })
	highlight("@string.escape", { fg = theme.escape })
	highlight("@lsp.type.invalidEscapeSequence", { fg = theme.error })
	highlight("@constant.macro", { fg = theme.macro })
	highlight("@lsp.typemod.operator.controlFlow", { fg = theme.keyword })
	highlight("@lsp.mod.static", { fg = theme.constant })

	-- Statuses
	highlight("@WarningMsg", { fg = theme.hint })

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

set_highlights()
