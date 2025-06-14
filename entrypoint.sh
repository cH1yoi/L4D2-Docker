#!/bin/bash

DEFAULT_ARGS="-game left4dead2 -sv_lan 0 host+port 20721 -maxplayers 31 +sv_setmax 31 +exec server.cfg +map c2m1_highway"
FINAL_ARGS="$DEFAULT_ARGS $*"

if [ -d "/plugins" ] && [ ! -z "$(ls -A /plugins)" ]; then
    echo "Creating plugins symlinks..."
    for plugin in /plugins/*; do
        if [ -f "$plugin" ]; then
            ln -sf "$plugin" "/home/hana/l4d2/left4dead2/$(basename $plugin)"
            echo "Linked plugin: $(basename $plugin)"
        fi
    done
fi

if [ -d "/maps" ] && [ ! -z "$(ls -A /maps)" ]; then
    echo "Creating maps symlinks..."
    for map in /maps/*; do
        if [ -f "$map" ]; then
            ln -sf "$map" "/home/hana/l4d2/left4dead2/addons/$(basename $map)"
            echo "Linked map: $(basename $map)"
        fi
    done
fi

echo "Starting server with command:"
echo "/home/hana/l4d2/srcds_run $FINAL_ARGS"
exec /home/hana/l4d2/srcds_run $FINAL_ARGS