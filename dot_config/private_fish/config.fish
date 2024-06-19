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

set -gx FZF_COMMON_OPTS "--walker-skip .git,node_modules,target"
set -gx FZF_CTRL_T_OPTS "$FZF_COMMON_OPTS --preview 'preview {}'"
set -gx FZF_ALT_C_OPTS "$FZF_COMMON_OPTS"
alias gb 'git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'
fzf --fish | source

set -l nix_profile "$HOME/.nix-profile/etc/profile.d/nix.sh"
test -e $nix_profile ; and fenv "source $nix_profile"

set -l iterm_shell_integration {$HOME}/.iterm2_shell_integration.fish
test -e  $iterm_shell_integration ; and source $iterm_shell_integration
