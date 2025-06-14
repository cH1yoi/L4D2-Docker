#!/bin/bash

if [ -d "/plugins" ] && [ "$(ls -A /plugins)" ]; then
    echo "Creating plugins symlinks..."
    for plugin in /plugins/*; do
        [ -e "$plugin" ] && ln -sf "$plugin" "/home/hana/l4d2/left4dead2$(basename "$plugin")"
        echo "Linked plugin: $plugin -> /home/hana/l4d2/left4dead2/$(basename "$plugin")"
    done
fi

echo "Current plugins in addons:"
ls -l /home/hana/l4d2/left4dead2/

echo "Starting server with command:"
echo "/home/hana/l4d2/srcds_run $@"
exec /home/hana/l4d2/srcds_run "$@"