# remove the default fish greeting
set fish_greeting

# set the default editor
set -gx EDITOR nvim

# --is-interactive is important to make bat previews in fzf work correctly
if status --is-interactive
	theme_gruvbox dark
end

fixit init fish | source
fzf --fish | source

set -gx FZF_CTRL_T_OPTS "--walker-skip .git,node_modules,target,.venv,.ruff_cache --preview 'fzf_preview {}'"

source $HOME/.local/bin/env.fish

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
