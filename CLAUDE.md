# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a declarative NixOS/nix-darwin configuration using Flakes, managing three systems:
- **nixpad** — Lenovo ThinkPad T480 (x86_64-linux)
- **nix-hp** — HP laptop (x86_64-linux)
- **macbook** — Apple Silicon MacBook (aarch64-darwin)

## Build Commands

```bash
# Apply NixOS configuration (run on the target host)
sudo nixos-rebuild switch --flake /home/jacob/.nix-config#nixpad
sudo nixos-rebuild switch --flake /home/jacob/.nix-config#nix-hp

# Apply macOS configuration
sudo darwin-rebuild switch --flake ~/Jacob/Coding/nix-config#macbook

# Test without switching (dry activation)
sudo nixos-rebuild test --flake /home/jacob/.nix-config#nixpad

# Update flake inputs
nix flake update --flake /home/jacob/.nix-config
```

## Repository Structure

```
flake.nix                  # Entry point: defines inputs and system outputs
hosts/<name>/              # Per-host system configuration
  default.nix              # Host-specific settings and module imports
  hardware-configuration.nix  # Auto-generated hardware config
home/jacob/
  default.nix              # Linux user home-manager config
  macbook.nix              # macOS user home-manager config
modules/nixos/             # Reusable NixOS system modules
modules/home-manager/      # Reusable home-manager user modules
```

## Architecture

### Flake Inputs
- **nixpkgs** (nixos-25.11) — stable packages
- **nixpkgs-unstable** — bleeding-edge packages (Brave, PrismLauncher, claude-code)
- **home-manager** (release-25.11) — user environment management
- **nix-darwin** (25.11) — macOS system management
- **nixos-hardware** — hardware-specific profiles (used for ThinkPad T480)

### Key NixOS Modules (`modules/nixos/`)
| Module | Purpose |
|--------|---------|
| `common.nix` | Bootloader (systemd-boot), LUKS FIDO2 unlock, timezone (America/Detroit), user setup |
| `desktop.nix` | Desktop environment switch between GNOME and XMonad |
| `nix.nix` | Flake support, store optimization, weekly GC |
| `xanmod-bore.nix` | XanMod kernel with BORE CPU scheduler |
| `undervolt.nix` | Intel CPU undervolting (T480 only: -70mV core/uncore, -40mV GPU) |
| `quad9-dot.nix` | Quad9 DNS-over-TLS with DNSSEC |
| `zram.nix` | Compressed RAM swap (50% of RAM, swappiness=180) |

### Key Home-Manager Modules (`modules/home-manager/`)
| Module | Purpose |
|--------|---------|
| `gnome.nix` | GNOME theme, extensions (Blur My Shell), Bibata cursor, dark mode |
| `xmonad.nix` | XMonad WM config (mod4+p = rofi launcher) |
| `xmobar.nix` | Status bar: CPU, memory, battery, date |
| `rofi.nix` | App launcher with gruvbox color scheme |
| `picom.nix` | Compositor with shadows, fading, 8px rounded corners |
| `dunst.nix` | Notification daemon (gruvbox theme) |
| `gruvbox.nix` | Shared dark color palette used across all WM modules |

### Desktop Environment Abstraction
Both Linux hosts use a `desktop` option (defined in `modules/home-manager/desktop.nix`) to toggle between GNOME and XMonad. This is set per-host in the home-manager config.

### Package Channel Strategy
Most packages come from stable nixpkgs. The unstable overlay is used selectively in `home/jacob/default.nix` for packages that need newer versions (Brave, PrismLauncher, claude-code-bin).
