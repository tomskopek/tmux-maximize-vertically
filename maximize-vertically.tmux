#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

main() {
		tmux bind-key M run-shell -b "$CURRENT_DIR/scripts/maximize_pane_vertically.sh"
}
main
