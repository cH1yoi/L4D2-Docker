#!/bin/bash

L4D2_DIR="/home/hana/l4d2/left4dead2"

# 处理插件目录
if [ -d "/plugins" ] && [ "$(ls -A /plugins)" ]; then
    echo "Creating symlinks for all files and directories in plugins..."
    for item in /plugins/*; do
        if [ -e "$item" ]; then
            basename=$(basename "$item")
            target="$L4D2_DIR/$basename"
            
            if [ -e "$target" ] && [ ! -L "$target" ]; then
                echo "Skipping existing directory/file: $target"
                continue
            }
            
            # 创建软链接
            ln -sf "$item" "$target"
            echo "Created symlink: $item -> $target"
        fi
    done
fi

echo "Current contents in left4dead2 directory:"
ls -la $L4D2_DIR

echo "Starting server with command:"
echo "/home/hana/l4d2/srcds_run $@"
exec /home/hana/l4d2/srcds_run "$@"