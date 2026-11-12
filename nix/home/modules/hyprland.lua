local mod = "ALT"
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
	leaf = "global",
	enabled = true,
	speed = 10,
	bezier = "default",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5.39,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4.79,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4.1,
	bezier = "easeOutQuint",
	style = "popin 80%",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 1.49,
	bezier = "linear",
	style = "popin 80%",
})
hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 1.73,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 1.46,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3.03,
	bezier = "quick",
})
hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 3.81,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 4,
	bezier = "easeOutQuint",
	style = "fade",
})
hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 1.5,
	bezier = "linear",
	style = "fade",
})
hl.animation({
	leaf = "fadeLayersIn",
	enabled = true,
	speed = 1.79,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeLayersOut",
	enabled = true,
	speed = 1.39,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "workspaces",
	enabled = false,
	speed = 1.94,
	bezier = "almostLinear",
	style = "fade",
})
hl.animation({
	leaf = "workspacesIn",
	enabled = false,
	speed = 1.21,
	bezier = "almostLinear",
	style = "fade",
})
hl.animation({
	leaf = "workspacesOut",
	enabled = false,
	speed = 1.94,
	bezier = "almostLinear",
	style = "fade",
})
hl.animation({
	leaf = "zoomFactor",
	enabled = true,
	speed = 7,
	bezier = "quick",
})

hl.bind(mod .. " + Return", hl.dsp.exec_cmd("kitty -1"))
hl.bind(mod .. " + V", hl.dsp.exec_cmd("neovide"))
hl.bind(mod .. " + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen_state({ internal = 1, client = 1, action = "toggle" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = 3, client = 3, action = "toggle" }))
hl.bind("F2", hl.dsp.exec_cmd("systemctl --user restart lila"))
hl.bind("F3", hl.dsp.exec_cmd("systemctl --user restart lila-ws"))
hl.bind(mod .. " + L", hl.dsp.layout("swapprev noloop"))
hl.bind(mod .. " + H", hl.dsp.layout("swapnext noloop"))
hl.bind(mod .. " + M", hl.dsp.layout("swapwithmaster"))
hl.bind(mod .. " + M", hl.dsp.layout("focusmaster master"))
hl.bind(mod .. " + minus", hl.dsp.workspace.toggle_special(""))
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special" }))
hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = 1 }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = 2 }))
hl.bind(mod .. " + 3", hl.dsp.focus({ workspace = 3 }))
hl.bind(mod .. " + 4", hl.dsp.focus({ workspace = 4 }))
hl.bind(mod .. " + 5", hl.dsp.focus({ workspace = 5 }))
hl.bind(mod .. " + 6", hl.dsp.focus({ workspace = 6 }))
hl.bind(mod .. " + 7", hl.dsp.focus({ workspace = 7 }))
hl.bind(mod .. " + 8", hl.dsp.focus({ workspace = 8 }))
hl.bind(mod .. " + 9", hl.dsp.focus({ workspace = 9 }))
hl.bind(mod .. " + 0", hl.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = 1 }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = 2 }))
hl.bind(mod .. " + SHIFT + 3", hl.dsp.window.move({ workspace = 3 }))
hl.bind(mod .. " + SHIFT + 4", hl.dsp.window.move({ workspace = 4 }))
hl.bind(mod .. " + SHIFT + 5", hl.dsp.window.move({ workspace = 5 }))
hl.bind(mod .. " + SHIFT + 6", hl.dsp.window.move({ workspace = 6 }))
hl.bind(mod .. " + SHIFT + 7", hl.dsp.window.move({ workspace = 7 }))
hl.bind(mod .. " + SHIFT + 8", hl.dsp.window.move({ workspace = 8 }))
hl.bind(mod .. " + SHIFT + 9", hl.dsp.window.move({ workspace = 9 }))
hl.bind(mod .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }))
hl.bind("CTRL + F9", hl.dsp.exec_cmd("sleep 0.5; hyprctl dispatch dpms off"))
hl.bind(mod .. " + EQUAL", hl.dsp.exec_cmd("rofi -show run"))
hl.bind(mod .. " + W", hl.dsp.exec_cmd("rofi -show window"))
hl.bind(mod .. " + Y", hl.dsp.exec_cmd("rofi -modi clipboard:cliphist-rofi -show clipboard"))
hl.bind(mod .. " + E", hl.dsp.layout("cycleprev noloop"), { repeating = true })
hl.bind(mod .. " + N", hl.dsp.layout("cyclenext noloop"), { repeating = true })
hl.bind(mod .. " + SHIFT + Left", hl.dsp.window.resize({ x = -20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 20, y = 0, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + Down", hl.dsp.window.resize({ x = 0, y = 20, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + Up", hl.dsp.window.resize({ x = 0, y = -20, relative = true }), { repeating = true })

hl.layer_rule({
	match = { namespace = "match:namespace rofi" },
	-- TODO: manual review — unmapped layer rule: "blur on"
})

hl.layer_rule({
	match = { namespace = "match:namespace notifications" },
	-- TODO: manual review — unmapped layer rule: "blur on"
})

hl.monitor({
	output = "",
	mode = "preferred",
	position = "auto",
	scale = "1",
})

hl.window_rule({
	match = {
		class = "firefox",
	},
	opacity = "1.0 override",
})

hl.window_rule({
	match = {
		class = "mpv",
	},
	opacity = "1.0 override",
})

hl.workspace_rule({
	workspace = "w[tv1] s[false]",
	gaps_out = 0,
	gaps_in = 0,
	decorate = false,
	-- rounding = false,
	-- shadow = false,
})

hl.config({
	animations = {
		enabled = true,
	},
	decoration = {
		blur = {
			enabled = true,
			passes = 2,
			size = 3,
		},
		glow = {
			color = "rgba(255,255,255,0.3)",
			enabled = true,
			range = 5,
		},
		shadow = {
			color = "rgba(255,255,255,0.03)",
			color_inactive = "rgba(0,0,0,0.6)",
			enabled = true,
			range = 30,
			render_power = 4,
		},
		active_opacity = 0.950000,
		dim_inactive = false,
		dim_strength = 0.050000,
		inactive_opacity = 0.800000,
		rounding = 30,
		rounding_power = 2,
	},
	ecosystem = {
		no_donation_nag = true,
		no_update_news = true,
	},
	general = {
		border_size = 0,
		col = {
			active_border = "rgb(89b4fa)",
			inactive_border = "rgb(6c7086)",
		},
		gaps_in = 12,
		gaps_out = { 21, 21, 7, 21 },
		layout = "master",
	},
	group = {
		groupbar = {
			col = {
				active = "rgb(89b4fa)",
				inactive = "rgb(6c7086)",
			},
			text_color = "rgb(cdd6f4)",
		},
		col = {
			border_active = "rgb(89b4fa)",
			border_inactive = "rgb(6c7086)",
			border_locked_active = "rgb(94e2d5)",
		},
	},
	input = {
		follow_mouse = 2,
		kb_layout = "us,us",
		kb_variant = "colemak,",
		repeat_delay = 180,
		repeat_rate = 64,
	},
	master = {
		allow_small_split = true,
		mfact = 0.660000,
		new_on_top = true,
		orientation = "right",
		special_scale_factor = 0.950000,
	},
	misc = {
		background_color = "rgb(1e1e2e)",
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		key_press_enables_dpms = true,
	},
})

hl.on("hyprland.start", function()
	hl.exec_cmd("neovide", { workspace = "1 silent" })
	hl.exec_cmd("kitty -1", { workspace = "1 silent" })
	hl.exec_cmd("firefox", { workspace = "2 silent" })
	hl.exec_cmd("neovide", { workspace = "3 silent" })
	hl.exec_cmd("kitty -1", { workspace = "3 silent" })
	hl.exec_cmd("spotify", { workspace = "7 silent" })
end)

hl.on("config.reloaded", function()
	hl.exec_cmd("hyprshade auto")
	hl.exec_cmd("systemctl --user start ashell")
	hl.exec_cmd("systemctl --user start hypridle")
end)
