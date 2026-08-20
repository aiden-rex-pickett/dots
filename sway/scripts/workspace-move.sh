# Moves left and right between workspaces, used by $Mod+Control+$right and $Mod+Control+$left
current=$(swaymsg -t get_workspaces | jq '.[] | select(.focused==true).num')

if [ "$1" = "prev" ]; then
    # Go to left but never wrap
    if [ "$current" -gt 1 ]; then
        swaymsg workspace $((current - 1))
    fi
elif [[ "$1" = "next" ]] && (swaymsg -t get_tree | jq --argjson ws "$current" -e '.nodes[].nodes[] | select(.type=="workspace" and .num==$ws) | recurse(.nodes[], .floating_nodes[]) | select(.type=="con" or .type=="floating_con")' > /dev/null || swaymsg -t get_tree | jq --argjson ws "$((current + 1))" -e '.nodes[].nodes[] | select(.type=="workspace" and .num==$ws) | recurse(.nodes[], .floating_nodes[]) | select(.type=="con" or .type=="floating_con")' > /dev/null); then
    # Go right, creating windows if not currently in empty workspace or if next workspace to left not empty
    swaymsg workspace $((current + 1))
fi
