set -gx EDITOR nvim
set -gx HOMEBREW_BUNDLE_FILE "$HOME/.config/brewfile/Brewfile"
set -g fish_greeting

alias wezterm $WEZTERM_EXECUTABLE
alias fish-config-file "$EDITOR $HOME/.config/fish/config.fish"

# Make GnuPG work correctly
set -gx GPG_TTY (tty)

if not functions -q fisher
	echo "Fisher is not installed. Run `install-fisher`."
end

if functions -q theme_gruvbox
	theme_gruvbox dark
end

# oh-my-posh init fish | source

if type -q starship
	starship init fish | source
else
	echo "Starship is not installed" 1>&2
end

if type -q direnv
	direnv hook fish | source
else
	echo "direnv is not installed" 1>&2
end

set nix_profile {$HOME}/.nix-profile/etc/profile.d/nix.sh
test -e $nix_profile ; and fenv "source $nix_profile"

set iterm_shell_integration {$HOME}/.iterm2_shell_integration.fish
test -e  $iterm_shell_integration ; and source $iterm_shell_integration

export PATH="$PATH:$HOME/.foundry/bin:/opt/homebrew/opt:/opt/homebrew/opt/ruby/bin:$HOME/go/bin:/opt/homebrew/opt/make/libexec/gnubin"
