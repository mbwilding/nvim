local M = {}

M.base = {
	transparent = "NONE",

	-- Default UI
	fg = "#bdbdbd",
	bg = "#000000",
	window_bg = "#090909",
	window_accent = "#202020",

	-- Colors
	blue = "#6c95eb",
	blue_light = "#4eade5",
	cyan = "#66c3cc",
	green = "#39cc8f",
	purple = "#9591ff",
	orange = "#ffb083",
	yellow = "#fce094",
	red = "#ff3333",
	pink_hot = "#fc60a8",
	pink = "#ed94c0",
	peach = "#f4b393",
	turquoise = "#2de1c2",
	salmon = "#e2856e",
	periwinkle = "#d4c2fc",
	gray = "#4f5258",
	--linen = "#ffede1",
}

M.code = {
	variable = M.base.orange,
	operator = M.base.fg,
	string = M.base.fg,
	delimiter = M.base.fg,
	number = M.base.pink,
	escape = M.base.pink,
	comment = M.base.gray,
	keyword = M.base.blue_light,
	struct = M.base.purple,
	enum = M.base.salmon,
	interface = M.base.turquoise,
	method = M.base.green,
	constant = M.base.periwinkle,
	member = M.base.blue,
	todo = M.base.cyan,
	macro = M.base.cyan,
	attribute = M.base.turquoise,
	error = M.base.red,
	namespace = M.base.peach,
	module = M.base.yellow,
	redundant = M.base.gray,
	hint = M.base.gray,
}

return M

-- Rider Dark
--return {
--	transparent = "NONE",
--
--	-- Default UI
--	fg = "#bdbdbd",
--	bg = "#000000",
--	window_bg = "#090909",
--	window_accent = "#202020",
--
--	-- Colors
--	blue = "#6c95eb",
--	blue_light = "#4eade5",
--	green = "#39cc8f",
--	purple = "#9591ff",
--	orange = "#ffb083",

--	-- Code
--	variable = "#bdbdbd",
--	operator = "#bdbdbd",
--	string = "#c9a26d",
--	number = "#ed94c0",
--	escape = "#ed94c0",
--	comment = "#85c46c",
--	keyword = "#6c95eb",
--	struct = "#c191ff",
--	enum = "#e1bfff",
--	interface = "#9591ff",
--	method = "#39cc8f",
--	constant = "#66c3cc",
--	member = "#66c3cc",
--	todo = "#66c3cc",
--	macro = "#4eade5",
--	attribute = "#c191ff",
--	error = "#ff3333",
--	hint = "#555555",
--	redundant = "#787878",
--	delimiter = "#999999",
--	namespace = "#ffb083",
--	module = "#ffd3b3",
--}
