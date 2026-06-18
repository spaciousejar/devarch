# Devarch OS — Project Board

> Copy these tasks into a GitHub Project board at:
> https://github.com/users/spaciousejar/projects/4
>
> Columns: **Backlog** | **In Progress** | **Done**

---

## Phase 1: Core Infrastructure

- [x] Create devarch GitHub repository
- [x] Scaffold repo structure (archiso/, packages/, .github/)
- [x] Create custom archiso profile from releng
- [x] Customize bootloaders (GRUB, syslinux, systemd-boot)
- [x] Configure package manifest with Hyprland + dev tools
- [x] Set up custom pacman.conf with devarch repo
- [x] Create local build scripts (build-local.sh, update-repo.sh)
- [ ] Build ISO locally and verify it boots in QEMU

## Phase 2: Custom Packages

- [x] devarch-hyprland-configs PKGBUILD
- [x] devarch-desktop-settings PKGBUILD
- [x] devarch-meta metapackage PKGBUILD
- [ ] Build and sign custom packages
- [ ] Publish packages to GitHub Pages pacman repo
- [ ] Test package installation on clean Arch system

## Phase 3: CI/CD

- [x] GitHub Actions: build-iso.yml
- [x] GitHub Actions: build-packages.yml
- [x] GitHub Actions: pages.yml (GitHub Pages deployment)
- [ ] Enable GitHub Pages on the repo (Settings → Pages)
- [ ] Test CI: push a tag and verify ISO release
- [ ] Test CI: push package change and verify repo update

## Phase 4: Hyprland Desktop Experience

- [x] Hyprland config (keybinds, animations, Tokyo Night theme)
- [x] Waybar config (workspaces, system tray, custom modules)
- [x] Rofi launcher config (dark theme, app launcher)
- [x] Dunst notification config
- [x] Kitty terminal config (Tokyo Night colors)
- [x] Hyprpaper config
- [ ] Custom Devarch wallpaper
- [ ] Plymouth boot splash
- [ ] SDDM/ greetd login manager configuration

## Phase 5: Developer Tooling

- [x] Dev toolchain packages (Node.js, Python, Go, Rust, Docker)
- [x] Shell enhancements (zsh, starship, zoxide, fzf)
- [x] Editor config (Neovim defaults)
- [ ] Docker + Podman pre-configuration
- [ ] Dev container templates
- [ ] Git configuration defaults

## Phase 6: Installer & Distribution

- [ ] Design Calamares installer module
- [ ] Create Devarch branding and artwork
- [ ] Set up ISO signing (GPG)
- [ ] Write installation documentation
- [ ] Set up community channels (Discussions, Wiki)
- [ ] First public release (v0.1.0)

## Phase 7: Polish & Scale

- [ ] Devarch icon theme
- [ ] Custom GTK theme refinements
- [ ] Performance tuning (kernel parameters, swappiness, etc.)
- [ ] Secure boot support
- [ ] ARM64 build pipeline
- [ ] Community contributions guide
