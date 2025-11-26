#!/bin/bash

CONTENT=$(curl -s http://ip-api.com/json/)
longitude=$(echo "$CONTENT" | jq .lon)
latitude=$(echo "$CONTENT" | jq .lat)

if pgrep -x wlsunset > /dev/null; then
    pkill -x wlsunset
    notify-send "Redshift" "Disabled"
else
    wlsunset -l "$latitude" -L "$longitude" &
    notify-send "Redshift" "Enabled"
fi

