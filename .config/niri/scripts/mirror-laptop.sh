#!/usr/bin/env bash
# Toggle a wl-mirror window that mirrors the laptop screen onto the first
# external monitor. Pressing the bind again closes the mirror.

set -euo pipefail

APP_ID="at.yrlf.wl_mirror"

notify() { notify-send -a "Screen mirror" "Screen mirror" "$1" || true; }

# Toggle off if a mirror is already running.
if pkill -x wl-mirror; then
    exit 0
fi

outputs=$(niri msg --json outputs)

# Laptop panel: first enabled built-in connector (eDP/LVDS/DSI).
laptop=$(jq -r '[to_entries[] | select(.value.logical != null)
                 | .key | select(test("^(eDP|LVDS|DSI)"))] | sort | .[0] // empty' <<<"$outputs")
if [[ -z $laptop ]]; then
    notify "No enabled laptop screen found."
    exit 1
fi

# First enabled output that isn't the laptop panel.
external=$(jq -r --arg laptop "$laptop" '[to_entries[] | select(.value.logical != null)
                 | .key | select(. != $laptop)] | sort | .[0] // empty' <<<"$outputs")
if [[ -z $external ]]; then
    notify "No external monitor detected."
    exit 1
fi

wl-mirror --fullscreen-output "$external" "$laptop" >/dev/null 2>&1 &
pid=$!
disown

# Wait for the mirror window to map, then make sure it sits on the external
# monitor and hand focus back to the laptop screen.
for _ in $(seq 50); do
    id=$(niri msg --json windows |
        jq -r --arg app "$APP_ID" --argjson pid "$pid" \
            '[.[] | select(.app_id == $app and .pid == $pid)] | .[0].id // empty')
    if [[ -n $id ]]; then
        niri msg action move-window-to-monitor --id "$id" "$external"
        niri msg action focus-monitor "$laptop"
        exit 0
    fi
    sleep 0.1
done

notify "wl-mirror window did not appear."
kill "$pid" 2>/dev/null || true
exit 1
