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


status.register("redshift",
    format="{period}")
    # format="{period} {temperature}")

# Shows the average load of the last minute and the last 5 minutes
# (the default value for format is used)
status.register("load",
    format="{avg1}")

status.register("mem",
    format="MEM {percent_used_mem}%",
    color="white",
    warn_percentage=80,
    alert_percentage=90)

def case_monitor(s):
    d=s.split(' ')
    return f'{d[0]}% {d[1]}% {d[2]}%'

status.register("file",
        interval=1,
        components={ "case": (case_monitor, "/tmp/crom-case-monitor") },
        format="Case {case}")

def aio_monitor(s):
    d=s.split(' ')
    return f'{d[0]}º {d[2]}%'

status.register("file",
        interval=1,
        components={ "aio": (aio_monitor, "/tmp/crom-aio-monitor"), },
        format="AIO {aio}")

def cpu_monitor(s):
    d=s.split(' ')
    return f'{d[0]} MHz {d[1]}º'

status.register("file",
        interval=1,
        components={ "cpu": (cpu_monitor, "/tmp/crom-cpu-monitor"), },
        format="{cpu}")

# status.register("cpu_usage_graph",
#     format="CPU {usage:2}",
#     start_color=green,
#     end_color=green
# )

status.register("cpu_usage_bar",
    format="{usage_bar_cpu0}{usage_bar_cpu1}{usage_bar_cpu2}{usage_bar_cpu3}{usage_bar_cpu4}{usage_bar_cpu5}{usage_bar_cpu6}{usage_bar_cpu7}{usage_bar_cpu8}{usage_bar_cpu9}{usage_bar_cpu10}{usage_bar_cpu11}{usage_bar_cpu12}{usage_bar_cpu13}{usage_bar_cpu14}{usage_bar_cpu15}{usage_bar_cpu16}{usage_bar_cpu17}{usage_bar_cpu18}{usage_bar_cpu19}{usage_bar_cpu20}{usage_bar_cpu21}{usage_bar_cpu22}{usage_bar_cpu23}",
    bar_type="vertical",
    start_color=green,
    end_color=red,
    dynamic_color=True
)

# Shows pulseaudio default sink volume
# Note: requires libpulseaudio from PyPI
status.register("pulseaudio",
    format="{volume} ♪",)

# Shows mpd status
status.register("mpd",
    format="♬ {artist}: {album} {status} {title}",
    max_field_len=50,
    status={
        "pause": "◾",
        "play": "▶",
        "stop": "◾",
    })

status.register("network",
    interface="enp7s0",
    format_up="{interface} {bytes_sent} k↑ {bytes_recv} k↓",
    format_down="X",
    dynamic_color = True,
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
