#!/usr/bin/env sh

symlink() {
    if [ ! -L "$2" ] && [ -n $DOTFILES_BACKUP ]; then
        backup "$2"
    fi
    ln -sf "$1" "$2"
    echo "installed $1 to $2"
}

remove_broken_symlinks() {
    find -L "$1" -type l | while read fn; do
        rm "$fn"
        echo "removed broken symlink: $fn"
    done
}


backup() {
    if [ ! -f "$1" ]; then
        return 0
    fi
    BAK_NAME="$1.bak"
    BAK_COUNT=0
    while [ -f "$BAK_NAME" ]; do
        BAK_COUNT=$((BAK_COUNT+1))
        BAK_NAME="$1.bak.$BAK_COUNT"
    done
    cp "$1" "$BAK_NAME"
    echo "backed up $1 to $BAK_NAME"
}
