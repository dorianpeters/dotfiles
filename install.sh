#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MICRO_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/micro"

mkdir -p "$MICRO_CONFIG_DIR"

echo "Linking micro configuration to $MICRO_CONFIG_DIR..."
for file in settings.json bindings.json init.lua; do
    target="$MICRO_CONFIG_DIR/$file"
    source="$DOTFILES_DIR/micro/$file"
    if [ -f "$source" ]; then
        if [ -e "$target" ] || [ -L "$target" ]; then
            if [ -L "$target" ] && [ "$(readlink -f "$target")" = "$(readlink -f "$source")" ]; then
                echo "  Already linked: $file"
                continue
            fi
            echo "  Backing up existing $file to ${file}.bak"
            mv "$target" "${target}.bak"
        fi
        ln -s "$source" "$target"
        echo "  Linked: $file -> $source"
    fi
done

echo "Micro setup complete!"
