#!/bin/bash

mkdir -p /home/hana/l4d2/left4dead2
mkdir -p /home/hana/l4d2/left4dead2/addons
mkdir -p /home/hana/l4d2/left4dead2/maps

if [ -d "/plugins" ] && [ "$(ls -A /plugins)" ]; then
    echo "Creating plugins symlinks..."
    for plugin in /plugins/*; do
        [ -e "$plugin" ] && ln -sf "$plugin" "/home/hana/l4d2/left4dead2/addons/$(basename "$plugin")"
        echo "Linked plugin: $plugin -> /home/hana/l4d2/left4dead2/addons/$(basename "$plugin")"
    done
fi

if [ -d "/maps" ] && [ "$(ls -A /maps)" ]; then
    echo "Creating maps symlinks..."
    for map in /maps/*; do
        [ -e "$map" ] && ln -sf "$map" "/home/hana/l4d2/left4dead2/maps/$(basename "$map")"
        echo "Linked map: $map -> /home/hana/l4d2/left4dead2/maps/$(basename "$map")"
    done
fi

echo "Current plugins in addons:"
ls -l /home/hana/l4d2/left4dead2/addons

echo "Current maps in maps:"
ls -l /home/hana/l4d2/left4dead2/maps

echo "Starting server with command:"
echo "/home/hana/l4d2/srcds_run $@"
exec /home/hana/l4d2/srcds_run "$@"