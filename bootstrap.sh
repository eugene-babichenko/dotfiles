#! /usr/bin/env sh

DIR=$(dirname "$0")
cd "$DIR"

. ./scripts/functions.sh

find * -name "setup.sh" | while read setup; do
    ./$setup
done

echo "done!"
