#!/usr/bin/env python3
import html
import json
from datetime import datetime

import requests

SUN, MOON = "\U000f0599", "\U000f0594"
PARTLY_DAY, PARTLY_NIGHT = "\U000f0595", "\U000f0f31"
CLOUD, FOG = "\U000f0590", "\U000f0591"
SHOWERS, RAIN, POURING = "\U000f0f33", "\U000f0597", "\U000f0596"
SLEET, SNOW, HEAVY_SNOW = "\U000f067f", "\U000f0598", "\U000f0f36"
THUNDER, THUNDER_RAIN = "\U000f0593", "\U000f067e"

YELLOW, LAVENDER, OVERLAY = "#f9e2af", "#b4befe", "#9399b2"
BLUE, SAPPHIRE, TEXT, PEACH = "#89b4fa", "#74c7ec", "#cdd6f4", "#fab387"

CONDITIONS = {}


def add(codes, icon, colour):
    for code in codes.split():
        CONDITIONS[code] = (icon, colour)


add("119 122", CLOUD, OVERLAY)
add("143 248 260", FOG, OVERLAY)
add("176 263 266 293 296 353", SHOWERS, BLUE)
add("299 302 356", RAIN, BLUE)
add("305 308 359", POURING, BLUE)
add("179 182 185 281 284 311 314 317 350 362 365 374 377", SLEET, SAPPHIRE)
add("320 323 326 368", SNOW, TEXT)
add("227 230 329 332 335 338 371 395", HEAVY_SNOW, TEXT)
add("200 392", THUNDER, PEACH)
add("386 389", THUNDER_RAIN, PEACH)


def is_night(weather):
    astronomy = weather["weather"][0]["astronomy"][0]
    observed = weather["current_condition"][0]["localObsDateTime"]
    now = datetime.strptime(observed, "%Y-%m-%d %I:%M %p").time()
    sunrise = datetime.strptime(astronomy["sunrise"], "%I:%M %p").time()
    sunset = datetime.strptime(astronomy["sunset"], "%I:%M %p").time()
    return not sunrise <= now < sunset


try:
    weather = requests.get("https://wttr.in/ankara?format=j1", timeout=5).json()
    now = weather["current_condition"][0]
    today = weather["weather"][0]
    code = now["weatherCode"]

    if code == "113":
        icon, colour = (MOON, LAVENDER) if is_night(weather) else (SUN, YELLOW)
    elif code == "116":
        icon, colour = (PARTLY_NIGHT, LAVENDER) if is_night(weather) else (PARTLY_DAY, YELLOW)
    else:
        icon, colour = CONDITIONS.get(code, (CLOUD, OVERLAY))

    description = html.escape(now["weatherDesc"][0]["value"].strip())
    data = {
        "text": f"<span foreground='{colour}'>{icon}</span> {now['temp_C']}°",
        "tooltip": f"{description}, feels like {now['FeelsLikeC']}°\n"
        f"Today {today['mintempC']}° to {today['maxtempC']}°\n"
        f"Humidity {now['humidity']}%, wind {now['windspeedKmph']} km/h",
    }
except Exception:
    data = {"text": "…", "tooltip": "wttr.in unreachable"}

print(json.dumps(data, ensure_ascii=False))
