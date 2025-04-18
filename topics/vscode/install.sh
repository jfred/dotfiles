#!/bin/bash

# Get the directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR"
SETTINGS_SRC="$SOURCE_DIR/settings.json"
KEYBINDINGS_SRC="$SOURCE_DIR/keybindings.json"

# Detect platform and set target path
if [[ "$OSTYPE" == "darwin"* ]]; then
    TARGET_DIR="$HOME/Library/Application Support/Code/User"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# Ensure target directory exists
mkdir -p "$TARGET_DIR"

# Backup existing files if not symlinks
for file in "settings.json" "keybindings.json"; do
    if [ -e "$TARGET_DIR/$file" ] && [ ! -L "$TARGET_DIR/$file" ]; then
        echo "Backing up existing $file to $file.backup"
        mv "$TARGET_DIR/$file" "$TARGET_DIR/$file.backup"
    fi
done

# Create symlinks
ln -sf "$SETTINGS_SRC" "$TARGET_DIR/settings.json"
ln -sf "$KEYBINDINGS_SRC" "$TARGET_DIR/keybindings.json"

echo "VS Code configuration symlinked successfully!"

${SCRIPT_DIR}/setup-extensions.sh
