#!/usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ./../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/fish)"

echo "setting up fish..."

mkdir -p "$FISH_CONFIG_DIR"
remove_broken_symlinks "$FISH_CONFIG_DIR"
find * -name "*.fish" -o -name "fishfile" | while read fn; do
    symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done

chsh -s $(which fish)

fish "$DESTINATION/config.sh"
