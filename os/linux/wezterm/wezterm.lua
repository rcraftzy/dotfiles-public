local wezterm = require("wezterm")
local config = {
	enable_wayland = true,
	font = wezterm.font({
		family = "Monaspace Neon",
		-- harfbuzz_features = { "calt=1", "clig=1", "liga=1" },
		weight = "Regular",
		scale = 1.0,
	}),
	use_fancy_tab_bar = false,
	enable_tab_bar = false,
	line_height = 1.8,
	-- 1.2
	-- hide_tab_bar_if_only_tab = true,
}

config.color_scheme = "Tokyo Night (Gogh)"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

return config
