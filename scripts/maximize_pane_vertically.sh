#!/usr/bin/env bash

# Get tmux option with default value
get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value
    option_value=$(tmux show-option -gqv "$option")
    if [[ -z "$option_value" ]]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

main() {
    local min_lines
    min_lines=$(get_tmux_option "@maximize-vertically-minimum-lines" "1")

    # Get active pane info
    local active_pane_id
    active_pane_id=$(tmux display-message -p '#{pane_id}')

    local active_pane_left
    active_pane_left=$(tmux display-message -p '#{pane_left}')

    local active_pane_right
    active_pane_right=$(tmux display-message -p '#{pane_right}')

    # Get all panes with their info
    local panes_in_column=()
    local other_pane_count=0

    while IFS=: read -r pane_id pane_left pane_right; do
        # Only consider panes in the same vertical column (same left AND right edges)
        if [[ "$pane_left" == "$active_pane_left" && "$pane_right" == "$active_pane_right" ]]; then
            if [[ "$pane_id" != "$active_pane_id" ]]; then
                panes_in_column+=("$pane_id")
                ((other_pane_count++))
            fi
        fi
    done < <(tmux list-panes -F '#{pane_id}:#{pane_left}:#{pane_right}')

    # If no other panes in column, nothing to do
    if [[ "$other_pane_count" -eq 0 ]]; then
        return 0
    fi

    # Calculate total column height by summing all pane heights + separators
    local column_height=0
    local pane_count_in_column=0
    while IFS=: read -r pane_id pane_left pane_right pane_height; do
        if [[ "$pane_left" == "$active_pane_left" && "$pane_right" == "$active_pane_right" ]]; then
            column_height=$((column_height + pane_height))
            ((pane_count_in_column++))
        fi
    done < <(tmux list-panes -F '#{pane_id}:#{pane_left}:#{pane_right}:#{pane_height}')

    # Add separator lines (one between each pair of panes)
    local separator_lines=$((pane_count_in_column - 1))
    column_height=$((column_height + separator_lines))

    # Shrink all other panes in the column to minimum height
    for pane_id in "${panes_in_column[@]}"; do
        tmux resize-pane -t "$pane_id" -y "$min_lines"
    done

    # Calculate and set the max height for active pane
    local target_height=$((column_height - (other_pane_count * min_lines) - separator_lines))

    tmux resize-pane -y "$target_height"
}

main
