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

    local active_pane_width
    active_pane_width=$(tmux display-message -p '#{pane_width}')

    # Get all panes with their info: id, width, height
    local panes_in_column=()
    local other_pane_count=0

    while IFS=: read -r pane_id pane_width pane_height; do
        # Only consider panes in the same vertical column (same width)
        if [[ "$pane_width" == "$active_pane_width" ]]; then
            if [[ "$pane_id" != "$active_pane_id" ]]; then
                panes_in_column+=("$pane_id")
                ((other_pane_count++))
            fi
        fi
    done < <(tmux list-panes -F '#{pane_id}:#{pane_width}:#{pane_height}')

    # If no other panes in column, nothing to do
    if [[ "$other_pane_count" -eq 0 ]]; then
        return 0
    fi

    # Shrink all other panes in the column to minimum height
    for pane_id in "${panes_in_column[@]}"; do
        tmux resize-pane -t "$pane_id" -y "$min_lines"
    done

    # Calculate and set the max height for active pane
    local window_height
    window_height=$(tmux display-message -p '#{window_height}')

    local separator_lines=$((other_pane_count))  # one separator per other pane
    local target_height=$((window_height - (other_pane_count * min_lines) - separator_lines))

    tmux resize-pane -y "$target_height"
}

main
