function install-fisher
	set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
	curl -sL git.io/fisher | source
	and fisher install jorgebucaran/fisher
	and chezmoi apply
	and fisher update
end
