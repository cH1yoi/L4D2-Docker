#!/bin/bash

L4D2_DIR="/home/hana/l4d2/left4dead2"

create_symlinks() {
    local src="$1"
    local dst="$2"
    
    for item in "$src"/*; do
        if [ -e "$item" ]; then
            local basename=$(basename "$item")
            local target="$dst/$basename"
            
            if [ -d "$item" ]; then
                mkdir -p "$target"
                create_symlinks "$item" "$target"
            else
                if [ ! -e "$target" ] || [ -L "$target" ]; then
                    ln -sf "$item" "$target"
                    echo "Created symlink: $item -> $target"
                else
                    echo "Skipping existing file: $target"
                fi
            fi
        fi
    done
}

if [ -d "/plugins" ] && [ "$(ls -A /plugins)" ]; then
    echo "Creating symlinks recursively..."
    create_symlinks "/plugins" "$L4D2_DIR"
fi

echo "Current contents in left4dead2 directory:"
ls -la $L4D2_DIR

echo "Starting server with command:"
echo "/home/hana/l4d2/srcds_run $@"
exec /home/hana/l4d2/srcds_run "$@"