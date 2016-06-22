# -*- coding: utf-8 -*-

import subprocess

from i3pystatus import Status

status = Status(standalone=True, click_events=False)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
# status.register("clock", format = [ ('%a %b %-d %b %X', 'UTC'), ("%a %-d %b %R", "%X") ])
    # format="%a %-d %b %R",)
status.register("clock", format = ('%H:%M UTC', 'UTC'))
status.register("clock", format = ("%a %-d %b %R", "Europe/Paris"))
    # format="%a %-d %b %R",)

# The battery monitor has many formatting options, see README for details

# This would look like this, when discharging (or charging)
# ↓14.22W 56.15% [77.81%] 2h:41m
# And like this if full:
# =14.22W 100.0% [91.21%]
#
# This would also display a desktop notification (via dbus) if the percentage
# goes below 5 percent while discharging. The block will also color RED.
status.register("battery",
    format="{status}/{consumption:.2f}W {percentage:.2f}% {remaining:%E%hh:%Mm}",
    color="#ff8888",
    full_color="#aaaaff",
    charging_color="#00bb00",
    alert=True,
    alert_percentage=10,
    status={
        "DIS": "↓",
        "CHR": "↑",
        "FULL": "=",
    },)

# Displays whether a DHCP client is running
# status.register("runwatch",
#     name="DHCP",
#     path="/var/run/dhclient*.pid",)

# Shows the address and up/down state of eth0. If it is up the address is shown in
# green (the default value of color_up) and the CIDR-address is shown
# (i.e. 10.10.10.42/24).
# If it's down just the interface name (eth0) will be displayed in red
# (defaults of format_down and color_down)
#
# Note: the network module requires PyPI package netifaces
# status.register("network",
#     interface="eth0",
#     format_up="{v4cidr}",
#     format_down="{interface}",
#     color_down="#888888")

# Shows disk usage of /
# Format:
# 42/128G [86G]
# status.register("disk",
#     path="/",
#     format="{avail}G",
#     round_size=None)

status.register("network",
    interface="wlp2s0",
    format_up="{essid} {quality:03.0f}%",
    graph_width=16,
    upper_limit=100,
    dynamic_color=False,
    color_up="#00bb00",
    color_down="#00bb00",
    start_color="#00bb00",
    graph_style="braille-fill")

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    format="{avg1}")

status.register("mem",
    format="MEM {percent_used_mem}%",
    color="#00bb00",
    warn_percentage=85,
    alert_percentage=90)

# Shows your CPU temperature, if you have a Intel CPU
status.register("temp",
    file="/sys/class/hwmon/hwmon0/temp1_input",
    interval=1,
    alert_temp=75,
    format="{temp:.0f}°",)

status.register("cpu_usage_graph",
    format="CPU {cpu_graph}",
    start_color="#00bb00",
    graph_width=16,
    graph_style="braille-fill")

# Shows pulseaudio default sink volume
#
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="♪{volume}",)

# Shows mpd status
status.register("mpd",
    format="{title} {status} {album}",
    max_field_len=50,
    status={
        "pause": "▷",
        "play": "▶",
        "stop": "◾",
    },)

status.run()
