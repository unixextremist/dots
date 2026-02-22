#!/bin/sh

command -v wmctrl >/dev/null 2>&1 || exit 1

workspaces=$(
    wmctrl -d | awk '
        {
            name = $NF
            if (name == "-" || name == "") name = "ws" $1
            if ($2 == "*") name = "[" name "]"
            printf "%s%s", sep, name
            sep = " / "
        }
    '
)

[ -z "$workspaces" ] && exit 1

if command -v notify-send >/dev/null 2>&1; then
    notify-send "workspaces" "$workspaces"
elif command -v herbe >/dev/null 2>&1; then
    herbe "workspaces: $workspaces"
else
    printf '%s\n' "$workspaces"
fi
