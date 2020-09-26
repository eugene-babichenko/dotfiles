# dotfiles

The collection of configuration files for my working environment.

## Prerequisites

### Fish

* `curl` - needed to install `fisher` (the package manager for `fish`).
* [`thefuck`][thefuck] - correct wrong or misspelled command by typing `fuck`.
* [`starship`][starship] - awesome `fish` prompt.
* [`fzf`][fzf] - fuzzy search in command history and files.

Install on Ubuntu:

	sudo apt update
	sudo apt install fish curl fzf python3 python3-pip
	curl -fsSL https://starship.rs/install.sh | bash
	pip3 install thefuck

## Contents

### Fish

* `functions`
	* `portainer` - start/restart/install [portainer][portainer].
	* `take` - create a directory and cd into it.
* `config` - settings for done notifications, path, load thefuck, hack `pure` theme.
* `fishfile` - list of `fish` plugins.
	* `done` - notifications about completions of command running in background shells.
	* [`z`][z] - quick fuzzy search in past directories (`z done` expands to `~/Projects/done` for me).
	* [`fzf`][fzf-fish] - eazy `fzf` integration.

### vim

No plugins, just some convenience settings.

### tmux

Some beautification.

## Installation

Run `./bootstrap.sh`. All configuration files will be symlinked in their places and backups of old configurations
`*.bak` will be created.

Individual parts of this configuration can be installed by running the corresponding `<dir>/setup.sh`.

[portainer]: https://www.portainer.io/
[thefuck]: https://github.com/nvbn/thefuck
[starship]: https://github.com/starship/starship
[fzf]: https://github.com/junegunn/fzf
[z]: https://github.com/jethrokuan/z
[fzf-fish]: https://github.com/jethrokuan/fzf
