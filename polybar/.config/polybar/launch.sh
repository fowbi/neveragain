#!/usr/bin/env bash
# Launch polybar, one instance per connected monitor.

# Terminate already running instances
polybar-msg cmd quit >/dev/null 2>&1 || killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 0.2; done

if type xrandr >/dev/null 2>&1; then
    for m in $(xrandr --query | awk '/ connected/ {print $1}'); do
        MONITOR=$m polybar --reload main &
    done
else
    polybar --reload main &
fi
