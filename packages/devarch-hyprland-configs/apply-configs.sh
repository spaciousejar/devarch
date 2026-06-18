#!/usr/bin/env bash
# devarch-apply-configs
# Copies Devarch system defaults to the current user's home directory
# Usage: devarch-apply-configs [user]

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

if [[ $# -eq 0 ]]; then
    TARGET_USER="${SUDO_USER:-$USER}"
else
    TARGET_USER="$1"
fi

TARGET_HOME="$(eval echo ~${TARGET_USER})"

if [[ ! -d "${TARGET_HOME}" ]]; then
    echo -e "${RED}Error: Home directory for '${TARGET_USER}' not found.${NC}"
    exit 1
fi

CONFIG_SRC="/usr/share/devarch/hyprland-configs"
CONFIG_DST="${TARGET_HOME}/.config"

echo -e "${CYAN}Applying Devarch configuration for ${TARGET_USER}...${NC}"

# Copy configs, preserving existing files with .bak
for dir in hypr waybar rofi dunst kitty; do
    if [[ -d "${CONFIG_SRC}/${dir}" ]]; then
        if [[ -d "${CONFIG_DST}/${dir}" ]]; then
            echo -e "  Backup existing ${dir} → ${dir}.bak"
            cp -r "${CONFIG_DST}/${dir}" "${CONFIG_DST}/${dir}.bak" 2>/dev/null || true
        fi
        echo -e "  Installing ${GREEN}${dir}${NC} config"
        cp -r "${CONFIG_SRC}/${dir}" "${CONFIG_DST}/"
    fi
done

# Set proper ownership
chown -R "${TARGET_USER}:${TARGET_USER}" "${CONFIG_DST}/hypr" \
    "${CONFIG_DST}/waybar" \
    "${CONFIG_DST}/rofi" 2>/dev/null || true

echo -e "${GREEN}✓ Configuration applied. Log out and back in to see changes.${NC}"
