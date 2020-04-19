#!/usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ./../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~)"

echo "setting up git..."

symlink "$SOURCE/.gitconfig" "$DESTINATION/.gitconfig"
