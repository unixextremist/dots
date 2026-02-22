#!/bin/sh

time=$(date '+%H:%M')

if command -v notify-send >/dev/null 2>&1; then
    notify-send "time" "$time"
elif command -v herbe >/dev/null 2>&1; then
    herbe "time: $time"
else
    printf '%s\n' "$time"
fi
