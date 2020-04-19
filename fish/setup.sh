#!/usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ./../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/fish)"

echo "setting up fish..."

mkdir -p "$DESTINATION"
remove_broken_symlinks "$DESTINATION"
find * -name "*.fish" -o -name "fishfile" | while read fn; do
	symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

sudo chsh -s $(which fish)

fish "$DESTINATION/config.fish"
