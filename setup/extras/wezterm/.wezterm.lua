-- ██╗    ██╗███████╗███████╗████████╗███████╗██████╗ ███╗   ███╗
-- ██║    ██║██╔════╝╚══███╔╝╚══██╔══╝██╔════╝██╔══██╗████╗ ████║
-- ██║ █╗ ██║█████╗    ███╔╝    ██║   █████╗  ██████╔╝██╔████╔██║
-- ██║███╗██║██╔══╝   ███╔╝     ██║   ██╔══╝  ██╔══██╗██║╚██╔╝██║
-- ╚███╔███╔╝███████╗███████╗   ██║   ███████╗██║  ██║██║ ╚═╝ ██║
--  ╚══╝╚══╝ ╚══════╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝

local wezterm = require("wezterm")
local os = require("os")

local colors = {
	-- special
	foreground = "#ffffff",
	darker_background = "#000000",
	background = "#000000",
	lighter_background = "#262626",
	one_background = "#393939",

	-- black
	color0 = "#262626",
	color8 = "#393939",

	-- red
	color1 = "#ee5396",
	color9 = "#ee5396",

	-- green
	color2 = "#42be65",
	color10 = "#42be65",

	-- yellow
	color3 = "#ffab91",
	color11 = "#ffab91",

	-- blue
	color4 = "#78a9ff",
	color12 = "#78a9ff",

	-- magenta
	color5 = "#ff7eb6",
	color13 = "#ff7eb6",

	-- cyan
	color6 = "#82cfff",
	color14 = "#82cfff",

	-- white
	color7 = "#dde1e6",
	color15 = "#f2f4f8",
}

local config = {
	-- OpenGL for GPU acceleration, Software for CPU
	front_end = "OpenGL",
	font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	font_size = 12.0,
	line_height = 1.0,
	harfbuzz_features = { "zero" },

	--- Cursor style
	-- default_cursor_style = "BlinkingUnderline",

	-- Keybinds
	disable_default_key_bindings = true,
	keys = {
		{
			key = "F11",
			--mods = "CTRL|SHIFT",
			action = wezterm.action.ToggleFullScreen,
		},
		{
			key = [[\]],
			mods = "CTRL|ALT",
			action = wezterm.action({
				SplitHorizontal = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = [[\]],
			mods = "CTRL",
			action = wezterm.action({
				SplitVertical = { domain = "CurrentPaneDomain" },
			}),
		},
		{
			key = "q",
			mods = "CTRL",
			action = wezterm.action({ CloseCurrentPane = { confirm = false } }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Left" }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Right" }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Up" }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivatePaneDirection = "Down" }),
		},
		{
			key = "h",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
		},
		{
			key = "l",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
		},
		{
			key = "k",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
		},
		{
			key = "j",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
		},
		{ -- browser-like bindings for tabbing
			key = "t",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }),
		},
		{
			key = "w",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ CloseCurrentTab = { confirm = false } }),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "Tab",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		}, -- standard copy/paste bindings
		{
			key = "x",
			mods = "CTRL|SHIFT",
			action = "ActivateCopyMode",
		},
		{
			key = "v",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ PasteFrom = "Clipboard" }),
		},
		{
			key = "c",
			mods = "CTRL|SHIFT",
			action = wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }),
		},
		{
			key = "-",
			mods = "CTRL",
			action = wezterm.action.DecreaseFontSize,
		},
		{
			key = "=",
			mods = "CTRL",
			action = wezterm.action.IncreaseFontSize,
		},
		{
			key = "0",
			mods = "CTRL",
			action = wezterm.action.ResetFontSize,
		},
	},

	bold_brightens_ansi_colors = false,
	colors = {
		background = colors.background,
		foreground = colors.foreground,

		cursor_bg = colors.foreground,
		cursor_fg = colors.foreground,
		cursor_border = colors.foreground,

		selection_fg = colors.background,
		selection_bg = colors.color4,

		scrollbar_thumb = colors.foreground,

		split = colors.lighter_background,

		ansi = {
			colors.color0,
			colors.color1,
			colors.color2,
			colors.color3,
			colors.color4,
			colors.color5,
			colors.color6,
			colors.color7,
		},

		brights = {
			colors.color8,
			colors.color9,
			colors.color10,
			colors.color11,
			colors.color12,
			colors.color13,
			colors.color14,
			colors.color15,
		},

		tab_bar = {
			active_tab = {
				bg_color = colors.background,
				fg_color = colors.foreground,
				italic = true,
			},
			inactive_tab = { bg_color = colors.darker_background, fg_color = colors.background },
			inactive_tab_hover = { bg_color = colors.one_background, fg_color = colors.darker_background },
			new_tab = { bg_color = colors.one_background, fg_color = colors.darker_background },
			new_tab_hover = { bg_color = colors.color4, fg_color = colors.darker_background },
		},
	},

	-- Padding
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
		--left = 15,
		--right = 15,
		--top = 15,
		--bottom = 15,
	},

	-- Tab Bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	show_tab_index_in_tab_bar = false,
	tab_bar_at_bottom = true,

	-- Transparency
	window_background_opacity = 0.975,
	--window_background_opacity = 0.9,

	-- General
	animation_fps = 1,
	cursor_blink_rate = 1000,
	cursor_blink_ease_in = "Constant",
	cursor_blink_ease_out = "Constant",
	enable_kitty_graphics = true,
	automatically_reload_config = true,
	inactive_pane_hsb = { saturation = 1.0, brightness = 1.0 },
	window_frame = { active_titlebar_bg = colors.darker_background },
	selection_word_boundary = " \t\n{}[]()\"'`,;:",
	warn_about_missing_glyphs = false,
	check_for_updates = false,
	window_close_confirmation = "NeverPrompt",
}

-- Not Windows
if os.getenv("OS") ~= "Windows_NT" then
	config.window_decorations = "RESIZE"
	config.enable_wayland = true
	config.exit_behavior = "CloseOnCleanExit"
end

-- Windows
if os.getenv("OS") == "Windows_NT" then
	config.default_prog = { "pwsh", "-NoLogo", "-NoProfile" }
	config.initial_cols = 120
	config.initial_rows = 30
end

return config
