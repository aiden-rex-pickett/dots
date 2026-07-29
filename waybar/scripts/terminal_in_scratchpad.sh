#!/bin/bash

swaymsg "exec ghostty --class=my.scratchpad.$2 -e bash -c '$1;'"

while ! swaymsg -t get_tree | jq -e --arg id "my.scratchpad.$2" '.. | select(.app_id? == $id)' >/dev/null; do
    sleep 0.05
done

swaymsg [app_id="my.scratchpad.$2"] move scratchpad

swaymsg [app_id="my.scratchpad.$2"] scratchpad show

swaymsg [app_id="my.scratchpad.$2"] move position center
