local colors = require("config/colors")

return {
	n = colors.orange, -- Normal
	i = colors.blue_light, -- Insert
	v = colors.green, -- Visual
	[''] = colors.keyword,
	V = colors.keyword,
	c = colors.orange,
	no = colors.macro,
	s = colors.orange,
	S = colors.orange,
	[''] = colors.orange,
	ic = colors.member,
	R = colors.number,
	Rv = colors.number,
	cv = colors.macro,
	ce = colors.macro,
	r = colors.todo,
	rm = colors.todo,
	['r?'] = colors.todo,
	['!'] = colors.macro,
	t = colors.macro,
}
