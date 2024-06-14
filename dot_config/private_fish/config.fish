set -gx EDITOR nvim
set -g fish_greeting

# Make GnuPG work correctly
set -gx GPG_TTY (tty)

if not functions -q fisher
	echo "Fisher is not installed. Run `install-fisher`."
end

theme_gruvbox dark

starship init fish | source
direnv hook fish | source
fixit init fish | source

set nix_profile {$HOME}/.nix-profile/etc/profile.d/nix.sh
test -e $nix_profile ; and fenv "source $nix_profile"

set iterm_shell_integration {$HOME}/.iterm2_shell_integration.fish
test -e  $iterm_shell_integration ; and source $iterm_shell_integration

export PATH="$PATH:$HOME/.foundry/bin:/opt/homebrew/opt:/opt/homebrew/opt/ruby/bin:$HOME/go/bin:/opt/homebrew/opt/make/libexec/gnubin:/Applications/WezTerm.app/Contents/MacOS"
