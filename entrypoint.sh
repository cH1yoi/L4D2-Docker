#!/bin/bash

if [ -d "/plugins" ] && [ "$(ls -A /plugins)" ]; then
    echo "Creating plugins symlinks..."
    for plugin in /plugins/*; do
        if [ -e "$plugin" ]; then
            target="/home/hana/l4d2/left4dead2/$(basename "$plugin")"
            ln -sf "$plugin" "$target"
            echo "Linked plugin: $plugin -> $target"
        fi
    done
fi

echo "Current plugins in addons:"
ls -la /home/hana/l4d2/left4dead2/addons/

echo "Starting server with command:"
echo "/home/hana/l4d2/srcds_run ${*}"
exec /home/hana/l4d2/srcds_run ${*}