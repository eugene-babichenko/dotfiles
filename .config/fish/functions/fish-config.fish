function fish-config -d "Configure fish shell and reload config"
  set -l config_file "$HOME/.config/fish/config.fish"
  $EDITOR $config_file
  source $config_file
end
