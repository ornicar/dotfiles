# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

green="#98c379"
red="#e06c75"
yellow="#d19a66"

status = Status(standalone=True, click_events=False)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
# status.register("clock", format = [ ('%a %b %-d %b %X', 'UTC'), ("%a %-d %b %R", "%X") ])
    # format="%a %-d %b %R",)
status.register("clock", format = ('UTC %H:%M', 'UTC'))
status.register("clock", format = ("FR %H:%M", "Europe/Paris"))
# status.register("clock", format = ("%H:%M"))
# status.register("clock", format = ("%a %-d %b %R", "Asia/Singapore"))
    # format="%a %-d %b %R",)

status.register("battery",
    format="{status}/{consumption:.2f}W {percentage:.2f}% {remaining:%E%hh:%Mm}",
    color=red,
    full_color=green,
    charging_color=green,
    alert=True,
    alert_percentage=10,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },)

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    format="{avg1}")

# status.register("mem",
#     format="MEM {percent_used_mem}%",
#     color="white",
#     warn_percentage=80,
#     alert_percentage=90)

status.register("temp",
    file="/sys/devices/platform/coretemp.0/hwmon/hwmon7/temp1_input",
    interval=2,
    alert_temp=100,
    color=green,
    alert_color=red,
    # dynamic_color=True,
    format="{temp:.0f}°",)

# status.register("temp",
#     file="/sys/class/hwmon/hwmon3/fan1_input",
#     interval=1,
#     alert_temp=3000,
#     format="{temp:.0f}°",)

# status.register("file",
#     components={
#         'rpm1': (int, "/sys/class/hwmon/hwmon3/fan1_input"),
#         'rpm2': (int, "/sys/class/hwmon/hwmon3/fan2_input")
#     },
#     format="Fans {rpm1} {rpm2}")

# status.register("cpu_freq",
#     file="/proc/cpuinfo",
#     interval=1,
#     format="{avgg} Ghz")

# status.register("cpu_usage_graph",
#     format="CPU {usage:2}",
#     start_color=green,
#     end_color=green
# )

status.register("cpu_usage_bar",
    format="{usage_bar_cpu0}{usage_bar_cpu1}{usage_bar_cpu2}{usage_bar_cpu3}{usage_bar_cpu4}{usage_bar_cpu5}{usage_bar_cpu6}{usage_bar_cpu7}{usage_bar_cpu8}{usage_bar_cpu9}{usage_bar_cpu10}{usage_bar_cpu11}",
    bar_type="vertical",
    start_color=green,
    end_color=red
)

# Shows pulseaudio default sink volume
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="{volume} ♪",)

# Shows mpd status
# status.register("mpd",
#     format="♬ {artist}: {album} {status} {title}",
#     max_field_len=50,
#     status={
#         "pause": "◾",
#         "play": "▶",
#         "stop": "◾",
#     })

# status.register("runwatch",
#     path="/tmp/lila-play-pid",
#     name="lila",
#     interval=2,
#     color_up=green,
#     color_down=red)

status.register("network",
    interface="wlan0",
    format_up="{bytes_sent} k↑ {bytes_recv} k↓ {essid} {quality}%",
    format_down="X",
    # dynamic_color = True,
    start_color=green,
    end_color=yellow,
    color_down=red,
)

# status.register("online",
#     format_online="✓",
#     format_offline="✗",
#     color=green,
#     color_offline=red)
# status.register("network",
#     interface="enp0s20f0u1",
#     unknown_up = True,
#     format_up="EXT {bytes_sent} kB/s↑ {bytes_recv} kB/s↓",
#     format_down="X",
#     dynamic_color = True,
#     start_color=green,
#     end_color=yellow,
#     color_down=red,
# )

status.run()
