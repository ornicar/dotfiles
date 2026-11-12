hl.config({
	input = {
		touchpad = {
			disable_while_typing = true,
		},
	},
})

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"))
hl.bind(
	"XF86AudioPlay",
	hl.dsp.exec_cmd("/nix/store/ym74pz54wwbw4247giavbkfz85p987zw-playerctl-2.4.1/bin/playerctl -p spotify play-pause")
)
hl.bind(
	"XF86AudioNext",
	hl.dsp.exec_cmd("/nix/store/ym74pz54wwbw4247giavbkfz85p987zw-playerctl-2.4.1/bin/playerctl -p spotify next")
)
hl.bind(
	"XF86AudioPrev",
	hl.dsp.exec_cmd("/nix/store/ym74pz54wwbw4247giavbkfz85p987zw-playerctl-2.4.1/bin/playerctl -p spotify previous")
)
hl.bind("Print", hl.dsp.exec_cmd("/home/thib/dotfiles/scripts/screenshot.sh clipboard"))
hl.bind("F10", hl.dsp.exec_cmd("/home/thib/dotfiles/scripts/systemctl-toggle.sh easyeffects"))
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.5"),
	{ repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- -l 0.0"),
	{ repeating = true }
)
hl.bind(
	"XF86MonBrightnessDown",
	hl.dsp.exec_cmd("/nix/store/dcdspdc1jar04nqkran03q8csnknj2fy-brightnessctl-0.5.1/bin/brightnessctl set 10%-"),
	{ repeating = true }
)
hl.bind(
	"XF86MonBrightnessUp",
	hl.dsp.exec_cmd("/nix/store/dcdspdc1jar04nqkran03q8csnknj2fy-brightnessctl-0.5.1/bin/brightnessctl set +10%"),
	{ repeating = true }
)
