local wezterm = require("wezterm")

return {
	color_scheme = "tokyonight",
	font = wezterm.font("SpaceMono Nerd Font"),
	font_size = 10,
	harfbuzz_features = { "calt=0", "clig=0", "liga=0" },
	enable_tab_bar = false,
	window_padding = {
		left = "15px",
		right = "15px",
		top = "15px",
		bottom = "15px",
	},
}
