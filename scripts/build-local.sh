#!/usr/bin/env bash
# Devarch local ISO builder
# Builds the Devarch ISO using the local archiso profile
# Usage: ./scripts/build-local.sh [--clean]

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORK_DIR="${REPO_ROOT}/build/work"
OUT_DIR="${REPO_ROOT}/out"
PROFILE_DIR="${REPO_ROOT}/archiso"

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════╗"
echo "║        Devarch ISO Builder                ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Check for root
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}This script must be run as root.${NC}"
    exit 1
fi

# Check archiso is installed
if ! command -v mkarchiso &>/dev/null; then
    echo -e "${RED}archiso is not installed. Install it with: sudo pacman -S archiso${NC}"
    exit 1
fi

# Clean flag
if [[ "${1:-}" == "--clean" ]]; then
    echo -e "${YELLOW}Cleaning previous build artifacts...${NC}"
    rm -rf "${WORK_DIR}"
    rm -rf "${OUT_DIR}"
    echo -e "${GREEN}✓ Clean complete${NC}"
fi

# Create output directory
mkdir -p "${OUT_DIR}"

echo -e "${CYAN}Building Devarch ISO...${NC}"
echo -e "  Profile: ${PROFILE_DIR}"
echo -e "  Work dir: ${WORK_DIR}"
echo -e "  Output: ${OUT_DIR}"
echo ""

# Build the ISO
mkarchiso -v -w "${WORK_DIR}" -o "${OUT_DIR}" "${PROFILE_DIR}"

echo -e "${GREEN}"
echo "╔══════════════════════════════════════════╗"
echo "║        Build Complete!                    ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Show the built ISO
ISO_FILE=$(ls -1 "${OUT_DIR}"/*.iso 2>/dev/null | head -1)
if [[ -n "${ISO_FILE}" ]]; then
    echo -e "ISO: ${GREEN}${ISO_FILE}${NC}"
    echo -e "Size: $(du -h "${ISO_FILE}" | cut -f1)"
    echo ""
    echo -e "To test with QEMU:"
    echo -e "  ${YELLOW}run_archiso -i ${ISO_FILE}${NC}"
    echo -e "  ${YELLOW}run_archiso -u -i ${ISO_FILE}${NC} (for UEFI)"
else
    echo -e "${RED}No ISO file found in output directory.${NC}"
    exit 1
fi
