# install fisher and plugins if not installed
if not functions -q fisher
	set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
	curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
	fish -c fisher
end

# notify when a command ran for 15 seconds
set -g __done_min_cmd_duration 15000

set -gx PATH $HOME/.cargo/bin $HOME/.local/bin $PATH

# Starship prompt
starship init fish | source

# Make GnuPG work correctly
set -gx GPG_TTY (tty)

if type -q thefuck
	thefuck --alias | source
end
