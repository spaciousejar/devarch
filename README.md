# Devarch

**Developer Arch Linux** — A developer-focused Arch Linux distribution with Hyprland, pre-configured for web development, container workflows, and modern tooling.

## Features

- **Hyprland** — Dynamic tiling Wayland compositor with eye candy
- **Pre-configured dev environment** — Git, Docker, Node.js, Python, Go, Rust toolchains ready out of the box
- **Custom pacman repository** — Devarch-specific packages with curated defaults
- **Reproducible builds** — GitHub Actions CI builds the ISO and package repository automatically
- **Tokyo Night themed** — Consistent dark theme across Hyprland, Waybar, Kitty, Rofi, and GTK

## Repository Structure

```
devarch/
├── archiso/                  # Custom archiso profile (based on releng)
│   ├── airootfs/             # Live environment root filesystem overlay
│   ├── efiboot/              # UEFI bootloader configuration
│   ├── grub/                 # GRUB bootloader configuration
│   ├── syslinux/             # BIOS bootloader configuration
│   ├── packages.x86_64       # Package manifest for the live ISO
│   ├── pacman.conf           # Pacman configuration with devarch repo
│   └── profiledef.sh         # ISO profile definition
├── packages/                 # PKGBUILDs for custom packages
│   ├── devarch-hyprland-configs/   # Hyprland, Waybar, Rofi, Kitty, Dunst configs
│   ├── devarch-desktop-settings/   # GTK, font, MIME, and environment settings
│   └── devarch-meta/               # Metapackage depending on full devarch stack
├── repo/                     # Pacman repository database and built packages
├── scripts/
│   ├── build-local.sh        # Build the ISO locally
│   └── update-repo.sh        # Update the pacman repository database
├── .github/workflows/
│   ├── build-iso.yml         # CI: build ISO on tags, upload as release
│   ├── build-packages.yml    # CI: build custom packages, update repo, deploy to Pages
│   └── pages.yml             # CI: deploy repo to GitHub Pages
└── README.md
```

## Prerequisites

- **Arch Linux** (or Arch-based distro)
- `archiso` package (`sudo pacman -S archiso`)
- At least 10 GB free disk space
- Root access for building ISO

## Building the ISO Locally

```bash
# Clone the repository
git clone https://github.com/spaciousejar/devarch.git
cd devarch

# Build the ISO (requires root)
sudo ./scripts/build-local.sh

# Boot the ISO in QEMU for testing
run_archiso -i out/*.iso        # BIOS
run_archiso -u -i out/*.iso     # UEFI
```

The built ISO will be in the `out/` directory.

## Building Custom Packages

```bash
# Build a specific package
cd packages/devarch-hyprland-configs
makepkg -si

# Build all packages and update the repository
cd ../..
./scripts/update-repo.sh
```

## CI/CD Pipelines

The project uses GitHub Actions for automated builds:

| Workflow | Trigger | Produces |
|---|---|---|
| `build-iso.yml` | Push to `main` with archiso changes, or tag `v*` | ISO artifact + GitHub Release |
| `build-packages.yml` | Push to `main` with package changes | Built packages deployed to GitHub Pages |
| `pages.yml` | Push to `main` with repo changes | GitHub Pages site for pacman repo |

### ISO Build

Push a version tag to trigger an ISO release:

```bash
git tag v0.1.0
git push origin v0.1.0
```

### Package Repository

Custom packages are served via GitHub Pages at:
```
https://spaciousejar.github.io/devarch/repo/x86_64/
```

Add to `/etc/pacman.conf` on installed systems:

```ini
[devarch]
SigLevel = Optional TrustAll
Server = https://spaciousejar.github.io/devarch/repo/$arch
```

## Package Overview

| Package | Description |
|---|---|
| `devarch-hyprland-configs` | System-wide Hyprland, Waybar, Rofi, Kitty, Dunst configurations |
| `devarch-desktop-settings` | GTK theme, icon theme, font settings, default apps |
| `devarch-meta` | Metapackage that installs the complete Devarch environment |

## Installation

> **Note:** A Calamares-based graphical installer is planned. For now, use the standard Arch installation process and then install the devarch packages.

1. Boot the Devarch ISO
2. Follow the standard [Arch installation guide](https://wiki.archlinux.org/title/Installation_guide)
3. After chrooting, add the devarch repo to `pacman.conf`
4. Install the metapackage: `pacman -S devarch-meta`
5. Enable and start services: `systemctl enable NetworkManager bluetooth docker`
6. Reboot into your new Devarch system

## License

MIT
