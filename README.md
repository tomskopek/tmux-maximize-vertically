# Tmux Maximize Vertically

### Usage
This will bind `prefix + M` to maximize a pane only vertically

### Demo
https://user-images.githubusercontent.com/4926143/136496307-5e78b5d3-de6f-4f6f-8b5f-9a1ccdf20b8e.mp4


# Installation

### With Plugin Manager (recommended):

1. Get [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm)

2. Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tomskopek/tmux-maximize-vertically'

3. Hit `prefix + I` to fetch the plugin and source it. That's it!

### Manual Installation:

1. Clone the repo:

`$ git clone https://github.com/tomskopek/tmux-maximize-vertically ~/clone/path`

2. Add this line to the bottom of `.tmux.conf`:

`run-shell ~/clone/path/maximize-vertically.tmux`

3. Reload TMUX environment with `$ tmux source-file ~/.tmux.conf`. That's it!
