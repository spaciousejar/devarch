#!/usr/bin/env bash
# Devarch pacman repository updater
# Adds built packages to the repo database and updates repo metadata
# Usage: ./scripts/update-repo.sh [--sign]

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
REPO_DIR="${REPO_ROOT}/repo"
REPO_NAME="devarch"
ARCH="x86_64"
REPO_DB="${REPO_DIR}/${REPO_NAME}.db.tar.gz"
REPO_FILES="${REPO_DIR}/${REPO_NAME}.files.tar.gz"
REPO_DB_DIR="${REPO_DIR}/${REPO_NAME}.db"
REPO_FILES_DIR="${REPO_DIR}/${REPO_NAME}.files"

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════╗"
echo "║    Devarch Repository Updater             ║"
echo "╚══════════════════════════════════════════╝"
echo -e "${NC}"

# Create repo directory
mkdir -p "${REPO_DIR}"

# Check for packages to add
PKG_COUNT=$(find "${REPO_DIR}" -maxdepth 1 -name "*.pkg.tar.*" 2>/dev/null | wc -l)

if [[ "${PKG_COUNT}" -eq 0 ]]; then
    echo -e "${YELLOW}No new packages found in ${REPO_DIR}.${NC}"
    echo "Place .pkg.tar.zst files in ${REPO_DIR} and re-run this script."
    exit 0
fi

echo -e "Found ${GREEN}${PKG_COUNT}${NC} package(s) to add."

# Check for repo-add command
if ! command -v repo-add &>/dev/null; then
    echo -e "${RED}repo-add not found. Install pacman-contrib.${NC}"
    exit 1
fi

# Sign packages if GPG key is available and --sign flag is passed
SIGN_OPT=""
if [[ "${1:-}" == "--sign" ]]; then
    if gpg --list-secret-keys --keyid-format LONG 2>/dev/null | grep -q "sec"; then
        SIGN_OPT="--sign"
        echo -e "${GREEN}Package signing enabled${NC}"
    else
        echo -e "${YELLOW}No GPG key found. Skipping signing.${NC}"
    fi
fi

# Add packages to repo database
echo -e "${CYAN}Updating repository database...${NC}"
cd "${REPO_DIR}"

for pkg in *.pkg.tar.*; do
    if [[ -f "${pkg}" ]]; then
        echo -e "  Adding: ${GREEN}${pkg}${NC}"
        repo-add ${SIGN_OPT} "${REPO_DB}" "${pkg}"
    fi
done

# Create human-readable symlink
ln -sf "${REPO_NAME}.db.tar.gz" "${REPO_DIR}/${REPO_NAME}.db"
ln -sf "${REPO_NAME}.files.tar.gz" "${REPO_DIR}/${REPO_NAME}.files"

echo ""
echo -e "${GREEN}✓ Repository updated.${NC}"
echo ""
echo -e "Repository contents:"
ls -lh "${REPO_DIR}"/*.pkg.tar.* "${REPO_DIR}"/*.db* "${REPO_DIR}"/*.files* 2>/dev/null || true
echo ""
echo -e "${CYAN}To use this repo from another machine, add to pacman.conf:${NC}"
echo -e "  [${REPO_NAME}]"
echo -e "  SigLevel = Optional TrustAll"
echo -e "  Server = https://spaciousejar.github.io/devarch/repo/\$arch"
echo ""
echo -e "${YELLOW}Note: Commit and push the repo directory to GitHub Pages to make it available.${NC}"
