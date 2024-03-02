local colors = {
	middle_fg    = "#bdbdbd",
	middle_bg    = "NONE",
	secondary_fg = "#bdbdbd",
	secondary_bg = "#2e313f",
	primary_fg   = "#000000",
	normal_bg    = "#6c95eb",
	insert_bg    = "#39cc8f",
	visual_bg    = "#c191ff",
	replace_bg   = "#c9a26d",
}

return {
	inactive = {
		a = { fg = colors.middle_fg, bg = colors.middle_bg, gui = "bold" },
		b = { fg = colors.middle_fg, bg = colors.middle_bg },
		c = { fg = colors.middle_fg, bg = colors.middle_bg },
	},
	normal = {
		a = { fg = colors.primary_fg, bg = colors.normal_bg, gui = "bold" },
		b = { fg = colors.secondary_fg, bg = colors.secondary_bg },
		c = { fg = colors.secondary_fg, bg = colors.middle_bg },
	},
	insert = {
		a = { fg = colors.primary_fg, bg = colors.insert_bg, gui = "bold" },
		b = { fg = colors.secondary_fg, bg = colors.secondary_bg },
	},
	visual = {
		a = { fg = colors.primary_fg, bg = colors.visual_bg, gui = "bold" },
		b = { fg = colors.secondary_fg, bg = colors.secondary_bg },
	},
	replace = {
		a = { fg = colors.primary_fg, bg = colors.replace_bg, gui = "bold" },
		b = { fg = colors.secondary_fg, bg = colors.secondary_bg },
	},
}
