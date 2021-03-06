#!/usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ./../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/fish)"

echo "setting up fish..."

mkdir -p "$DESTINATION"
mkdir -p "$DESTINATION/functions"
remove_broken_symlinks "$DESTINATION"
find * -name "*.fish" -o -name "fish_plugins" | while read fn; do
	symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

sudo chsh -s $(which fish)
