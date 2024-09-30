set -gx EDITOR nvim
set -g fish_greeting

# Make GnuPG work correctly
set -gx GPG_TTY (tty)

if status --is-interactive
	theme_gruvbox dark
end

starship init fish | source
direnv hook fish | source
fixit init fish | source
fzf --fish | source

set -gx FZF_CTRL_T_OPTS "--walker-skip .git,node_modules,target --preview 'fzf_preview {}'"

alias gb 'git branch | grep -v "^\*" | fzf --height=20% --reverse --info=inline | xargs git checkout'

set -l nix_profile "$HOME/.nix-profile/etc/profile.d/nix.sh"
test -e $nix_profile ; and fenv "source $nix_profile"

set -l iterm_shell_integration {$HOME}/.iterm2_shell_integration.fish
test -e  $iterm_shell_integration ; and source $iterm_shell_integration

set -gx PNPM_HOME "/Users/eugene/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
