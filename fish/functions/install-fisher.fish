function install-fisher
	echo "Installing fisher..."
	set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
	curl -sL git.io/fisher | source && fisher install jorgebucaran/fisher
	fisher update
	echo "Done!"
end
