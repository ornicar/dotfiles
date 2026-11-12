hl.bind("F8", hl.dsp.exec_cmd("playerctl -p spotify play-pause"))
hl.bind("F9", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 1.0"), { repeating = true })
hl.bind("F10", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0"), { repeating = true })
hl.bind("ALT + F10", hl.dsp.exec_cmd("~/dotfiles/scripts/screenshot.sh clipboard"))
hl.bind("ALT + B", hl.dsp.workspace.toggle_special("mic"))
hl.bind("ALT + SHIFT + B", hl.dsp.window.move({ workspace = "special:mic" }))
-- my mouse middle-button is broken. Copy the primary selection to the secondary, so I can paste it.
hl.bind("CTRL + Y", hl.dsp.exec_cmd("wl-paste -p | wl-copy --trim-newline"))

hl.config({
	input = {
		repeat_delay = 180,
	},
})
