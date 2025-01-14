import requests
import time
import colorsys

api_url = "http://127.0.0.1:11987"
asus_aura = "f226946857a3141b80fefa0bae8de91cdba1c6eedf91d96ea7bef76ce88b4e90"
fans_name = "led2"
set_color_url = f"{api_url}/devices/{asus_aura}/settings/{fans_name}/lighting"
cpu_temp_file = "/sys/class/hwmon/hwmon2/temp1_input"
mode_req_file = "/tmp/coolercontrol-mode"

s = requests.Session()
s.auth = ('CCAdmin', 'ygNa96IfIBx5EbCT')
s.post(f"{api_url}/login")
s.headers.update({'content-type': 'application/json'})

ambient = 20

def temp_to_factor(temp):
    min_temp = ambient + 20
    max_temp = ambient + 40
    diff_temp = max_temp - min_temp
    return max(0, min(1, (temp - min_temp) / diff_temp))

def bezier_blend(f):
    return f * f * (3.0 - 2.0 * f)

def ease_in_out_quad(x):
    return 2 * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 2) / 2

def ease_in_out_cubic(x):
    return 4 * x * x * x if x < 0.5 else 1 - pow(-2 * x + 2, 3) / 2

def temp_to_rgb_white(temp):
    f = temp_to_factor(int(temp * 10) / 10)
    hue = (1-f) * 60
    saturation = ease_in_out_cubic(f)
    value = min(1, 0.1 + ease_in_out_quad(f))
    r, g, b = colorsys.hsv_to_rgb(hue / 360, saturation, value)
    rgb = [int(x * 255) for x in [r, g, b]]
    # print(f"temp: {int(temp * 10)}, {int(f * 100)}%, {int(hue)} {int(saturation * 100)} {int(value * 100)} rgb: {rgb}")
    return rgb

# nice cool rgb(179, 0, 255) = hsv(282, 100, 100)
def temp_to_rgb_purple(temp):
    f = temp_to_factor(int(temp * 10) / 10)
    hue = 250 + f * 110
    saturation = 1
    value = min(1, 0.2 + ease_in_out_quad(f))
    r, g, b = colorsys.hsv_to_rgb(hue / 360, saturation, value)
    rgb = [int(x * 255) for x in [r, g, b]]
    # print(f"temp: {int(temp * 10)}, {int(f * 100)}%, {int(hue)} {int(saturation * 100)} {int(value * 100)} rgb: {rgb}")
    return rgb

temp_to_rgb = temp_to_rgb_purple

prev_color_mode = None

def set_color_mode(color_mode):
    global prev_color_mode
    changed = prev_color_mode != color_mode
    if changed:
        print(color_mode['colors'][0])
        s.put(set_color_url, json=color_mode)
        prev_color_mode = color_mode
    return changed

def set_color(rgb):
    set_color_mode({"mode": "static", "colors": [rgb]})

def read_temp():
    with open(cpu_temp_file, "r") as f:
        return int(f.read().strip()) / 1000


modes = [(m['uid'], m['name']) for m in s.get(f"{api_url}/modes").json()['modes']]
default_uid = next((uid for (uid, name) in modes if name == "default"), None)
req_mode_name = None
prev_mode_name = None

def ensure_mode():
    global req_mode_name, prev_mode_name, prev_color_mode
    try:
        with open(mode_req_file, "r") as f:
            req_mode_name = f.read().strip()
    except FileNotFoundError:
        req_mode_name = "default"
    if req_mode_name != prev_mode_name:
        req_mode_uid = next((uid for (uid, name) in modes if name == req_mode_name), None)
        print(f"Setting mode to {req_mode_name} = {req_mode_uid}")
        s.post(f"{api_url}/modes-active/{req_mode_uid}")
        prev_mode_name = req_mode_name
        prev_color_mode = None
        time.sleep(0.7)

while True:
    ensure_mode()
    if req_mode_name == "sleep":
        time.sleep(1)
    elif not set_color(temp_to_rgb(read_temp())):
        time.sleep(0.5) # extra sleep when temp is constant
    else:
        time.sleep(0.3)
