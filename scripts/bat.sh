#!/bin/sh

battery_path="/sys/class/power_supply/BAT0"
[ -d "$battery_path" ] || battery_path="/sys/class/power_supply/BAT1"
[ -d "$battery_path" ] || exit 1

capacity=$(cat "$battery_path/capacity" 2>/dev/null)
status=$(cat "$battery_path/status" 2>/dev/null)

[ -z "$capacity" ] && exit 1

battery_info="${capacity}% (${status})"

if command -v notify-send >/dev/null 2>&1; then
    notify-send "battery" "$battery_info"
elif command -v herbe >/dev/null 2>&1; then
    herbe "battery: $battery_info"
else
    printf '%s\n' "$battery_info"
fi
