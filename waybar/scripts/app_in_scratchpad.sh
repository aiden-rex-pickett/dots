#!/bin/bash

$1 &

while ! swaymsg -t get_tree | jq -e --arg id "$2" '.. | select(.app_id? == $id)' >/dev/null; do
    sleep 0.05
done

swaymsg "[app_id=\"$2\"] move scratchpad; [app_id=\"$2\"] scratchpad show; [app_id=\"$2\"] move position center"
