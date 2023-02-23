local wezterm = require("wezterm")

return {
	font = wezterm.font("FiraCode Nerd Font"),
	font_size = 18,
	color_scheme = "Catppuccin Mocha",
	enable_tab_bar = false,
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	keys = {
		{ key = "p", mods = "ALT", action = wezterm.action.Paste },
	},
	mouse_bindings = {
		{
			event = { Up = { streak = 1, button = "Middle" } },
			mods = "NONE",
			action = wezterm.action.PasteFrom("PrimarySelection"),
		},
	},
}
