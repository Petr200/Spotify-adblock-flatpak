# 🎧 Spotify Adblock Flatpak

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-FCC624.svg)](https://www.linux.org/)

> Skip Spotify ads instantly on Linux (Flatpak) with near-zero CPU usage.

A lightweight Bash script that automatically detects and skips audio advertisements in the Flatpak version of Spotify.
Includes **single-instance protection** via `flock` so it can safely run in the background.

---

## 📑 Table of Contents

* [✨ Key Features](#-key-features)
* [📋 Prerequisites](#-prerequisites)
* [🚀 Installation](#-installation)

  * [Quick Install (One Command)](#quick-install-one-command)
  * [Manual Installation](#manual-installation)
  * [What the Installer Does](#what-the-installer-does)
* [⚙️ Configuration & Customization](#-configuration--customization)
* [🔄 Updating](#-updating)
* [⚙️ How It Works](#-how-it-works)
* [🛠️ Troubleshooting](#-troubleshooting)
* [🗑️ Uninstallation](#-uninstallation)
* [⚖️ Disclaimer](#-disclaimer)

---

## ✨ Key Features

* 🚫 No Spotify binary modification
* ⚡ Event-driven (almost zero CPU usage)
* 🔁 Automatic restart when ads are detected
* 🔕 Optional notifications
* 🛡️ Single instance guaranteed via `flock`
* 🚀 Autostart support

---

## 📋 Prerequisites

### Spotify (Flatpak)

```bash
flatpak install flathub com.spotify.Client
```

### Dependencies (by distro)

#### Ubuntu / Debian / Linux Mint / Pop!_OS

```bash
sudo apt update
sudo apt install playerctl libnotify-bin
```

#### Fedora

```bash
sudo dnf install playerctl libnotify
```

> ℹ️ Notifications and `--minimized` work reliably on Fedora KDE Plasma.

#### Arch / Manjaro / EndeavourOS

```bash
sudo pacman -S playerctl libnotify
```

#### openSUSE

```bash
sudo zypper install playerctl libnotify-tools
```

#### Tiling WMs / Wayland

* Install a notification daemon if needed:

```bash
sudo pacman -S dunst  # Arch
sudo apt install dunst # Debian/Ubuntu
sudo pacman -S mako   # Wayland
```

---

## 🚀 Installation

### Quick Install (One Command)

```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

### Manual Installation

```bash
git clone https://github.com/Petr200/Spotify-adblock-flatpak.git
cd Spotify-adblock-flatpak
chmod +x spotify-skipper.sh
./spotify-skipper.sh
```

### What the Installer Does

* Downloads the script to `~/.local/bin`
* Makes it executable
* Creates autostart entry (`~/.config/autostart`)
* Stops any old instance (if exists)
* Starts it in the background

---

## ⚙️ Configuration & Customization

### 🔕 Disable notifications

Edit `spotify-skipper.sh` and comment/remove lines with:

```bash
notify-send ...
```

### 🪟 About `--minimized`

```bash
flatpak run com.spotify.Client --minimized
```

| Environment       | Works?            |
| ----------------- | ----------------- |
| Fedora KDE Plasma | ✅ Fully           |
| Fedora GNOME      | ✅ Usually         |
| Ubuntu GNOME      | ✅ Yes             |
| XFCE              | ⚠️ Sometimes      |
| i3 / sway         | ❌ Usually ignored |

**Alternatives**

* Always open window:

```bash
flatpak run com.spotify.Client
```

* WM rule example (i3):

```bash
for_window [class="Spotify"] move scratchpad
```

### 🔁 Single instance

Already built-in using `flock`:

```bash
exec {LOCK_FD}>/tmp/spotify-adblock.lock
if ! flock -n "$LOCK_FD"; then
    notify-send -t 1600 -i com.spotify.Client -a "Spotify Adblock" "Script is already running."
    exit 1
fi
```

---

## 🔄 Updating

```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

---

## ⚙️ How It Works

1. Listens to Spotify using `playerctl --follow`
2. Detects ads via track IDs containing `spotify/ad`
3. Kills Spotify if an ad is detected
4. Restarts Spotify with `--minimized`
5. Resumes playback
6. Ensures only one instance is running via `flock`

---

## 🛠️ Troubleshooting

* Ads not skipping:

```bash
flatpak list | grep spotify
```

* Script not running:

```bash
ps aux | grep spotify-skipper
```

* Spotify opens in foreground → `--minimized` ignored by your DE/WM

* Notifications not working → check if `notify-send` is installed and daemon is running

---

## 🗑️ Uninstallation

```bash
pkill -f spotify-skipper.sh
rm ~/.local/bin/spotify-skipper.sh
rm ~/.config/autostart/spotify-skipper.desktop
rm /tmp/spotify-adblock.lock
```

---

## ⚖️ Disclaimer

* No Spotify binaries are modified
* May violate Spotify Terms of Service
* Use at your own risk
