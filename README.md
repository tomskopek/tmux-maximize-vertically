# Tmux Maximize Vertically

Maximize your tmux pane vertically while keeping other panes visible with a configurable minimum height.

## Usage

Press `prefix + M` to toggle vertical maximization of the current pane.

### Demo

https://user-images.githubusercontent.com/4926143/136496307-5e78b5d3-de6f-4f6f-8b5f-9a1ccdf20b8e.mp4

## Configuration

Add these options to your `.tmux.conf` before loading the plugin:

```bash
# Minimum number of lines to show for non-maximized panes (default: 1)
set -g @maximize-vertically-minimum-lines 3
```

This ensures that when you maximize a pane, other panes still show the specified number of lines, allowing you to see their content.

## Installation

### With TPM (recommended)

1. Install [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

2. Add the plugin to your `.tmux.conf`:

```bash
set -g @plugin 'tomskopek/tmux-maximize-vertically'
```

3. Press `prefix + I` to install the plugin.

### Manual Installation

1. Clone the repository:

```bash
git clone https://github.com/tomskopek/tmux-maximize-vertically ~/clone/path
```

2. Add this line to the bottom of `.tmux.conf`:

```bash
run-shell ~/clone/path/maximize-vertically.tmux
```

3. Reload tmux configuration:

```bash
tmux source-file ~/.tmux.conf
```
