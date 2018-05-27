# Tmux Maximize Vertically

### Usage
This will bind `prefix + M` to maximize a pane only vertically

### Demonstration

![](https://media.giphy.com/media/4Z5lIIX1H5Nngcp1YJ/giphy.gif)

### Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

    set -g @plugin 'tomskopek/tmux-maximize-vertically'

Hit `prefix + I` to fetch the plugin and source it. That's it!

### Manual Installation

Clone the repo:

    $ git clone https://github.com/tomskopek/tmux-maximize-vertically ~/clone/path

Add this line to the bottom of `.tmux.conf`:

    run-shell ~/clone/path/maximize-vertically.tmux

Reload TMUX environment with `$ tmux source-file ~/.tmux.conf`, and that's it.
