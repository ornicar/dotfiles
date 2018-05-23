# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

status = Status(standalone=True, click_events=False)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
# status.register("clock", format = [ ('%a %b %-d %b %X', 'UTC'), ("%a %-d %b %R", "%X") ])
    # format="%a %-d %b %R",)
status.register("clock", format = ('UTC %H:%M', 'UTC'))
status.register("clock", format = ("%a %-d %b %R", "Europe/Paris"))
    # format="%a %-d %b %R",)

status.register("battery",
    format="{status}/{consumption:.2f}W {percentage:.2f}% {remaining:%E%hh:%Mm}",
    color="#ff8888",
    full_color="#639B24",
    charging_color="#639B24",
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

status.register("mem",
    format="MEM {percent_used_mem}%",
    color="#639B24",
    warn_percentage=80,
    alert_percentage=90)

# status.register("temp",
#     file="/sys/devices/platform/coretemp.0/hwmon/hwmon2/temp1_input",
#     interval=1,
#     alert_temp=75,
#     format="{temp:.0f}°",)

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

status.register("cpu_freq",
    file="/sys",
    interval=1,
    format="{avgg} Ghz")

status.register("cpu_usage_graph",
    format="CPU {usage:2}",
    start_color="#639B24"
)

# Shows pulseaudio default sink volume
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="{volume} ♪",)

# Shows mpd status
status.register("mpd",
    format="{title} {status} {album}",
    max_field_len=50,
    status={
        "pause": "▷",
        "play": "▶",
        "stop": "◾",
    })

status.register("network",
    interface="wlp2s0",
    format_up="BCM {bytes_sent} kB/s↑ {bytes_recv} kB/s↓",
    format_down="X",
    dynamic_color = True,
    start_color="#639B24",
    end_color="yellow",
    color_down="#ff2222",
)
# status.register("network",
#     interface="enp0s20f0u1",
#     unknown_up = True,
#     format_up="EXT {bytes_sent} kB/s↑ {bytes_recv} kB/s↓",
#     format_down="X",
#     dynamic_color = True,
#     start_color="#639B24",
#     end_color="yellow",
#     color_down="#ff2222",
# )

status.run()
