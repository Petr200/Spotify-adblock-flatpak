# 🎧 Spotify Adblock Flatpak
![CI](https://github.com/Petr200/Spotify-adblock-flatpak/actions/workflows/test.yml/badge.svg)

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

## 1️⃣ Install Flatpak (if not installed)

### Ubuntu / Debian

```bash
sudo apt install flatpak
```

### Fedora

```bash
sudo dnf install flatpak
```

### Arch / Manjaro

```bash
sudo pacman -S flatpak
```

---

## 2️⃣ Add Flathub repository

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

---

## 3️⃣ Install Spotify (Flatpak)

```bash
flatpak install flathub com.spotify.Client
```

---

## 4️⃣ Install dependencies

### Ubuntu / Debian / Mint / Pop!_OS

```bash
sudo apt update
sudo apt install playerctl libnotify-bin
```

### Fedora

```bash
sudo dnf install playerctl libnotify
```

> ℹ️ Notifications and `--minimized` work perfectly on Fedora KDE Plasma.

### Arch / Manjaro

```bash
sudo pacman -S playerctl libnotify
```

### openSUSE

```bash
sudo zypper install playerctl libnotify-tools
```

---

## 🚀 Installation

## Quick Install (One Command)

```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

---

## Manual Installation

```bash
git clone https://github.com/Petr200/Spotify-adblock-flatpak.git
cd Spotify-adblock-flatpak
chmod +x spotify-adblock.sh
./spotify-adblock.sh
```

---

## What the Installer Does

* Downloads script to `~/.local/bin/spotify-adblock.sh`
* Makes it executable
* Creates autostart entry (`~/.config/autostart/spotify-adblock.desktop`)
* Stops any old instance
* Starts script in background

---

## ⚙️ Configuration & Customization

### 🔕 Disable notifications

Edit:

```bash
~/.local/bin/spotify-adblock.sh
```

Comment/remove:

```bash
notify-send ...
```

---

### 🪟 About `--minimized`

```bash
flatpak run com.spotify.Client --minimized
```

| Environment       | Works?       |
| ----------------- | ------------ |
| Fedora KDE Plasma | ✅ Fully      |
| Fedora GNOME      | ✅ Usually    |
| Ubuntu GNOME      | ✅ Yes        |
| XFCE              | ⚠️ Sometimes |
| i3 / sway         | ❌ Ignored    |

**Alternatives**

Always open window:

```bash
flatpak run com.spotify.Client
```

i3 workaround:

```bash
for_window [class="Spotify"] move scratchpad
```

---

### 🔁 Single instance protection

```bash
exec {LOCK_FD}>/tmp/spotify-adblock.lock
if ! flock -n "$LOCK_FD"; then
    notify-send -t 1600 -i com.spotify.Client -a "Spotify Adblock" "Already running"
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

1. Monitors Spotify via `playerctl --follow`
2. Detects ads (`spotify/ad`)
3. Kills Spotify when ad appears
4. Restarts it with `--minimized`
5. Resumes playback
6. Prevents duplicate instances via `flock`

---

## 🛠️ Troubleshooting

### Script downloaded incorrectly (404)

```bash
cat ~/.local/bin/spotify-adblock.sh
```

If you see:

```
404: Not Found
```

→ reinstall.

---

### Check Spotify

```bash
flatpak list | grep spotify
```

---

### Check script running

```bash
ps aux | grep spotify-adblock
```

---

### Debug mode

```bash
bash -x ~/.local/bin/spotify-adblock.sh
```

---

### Notifications not working

Install daemon:

```bash
sudo apt install dunst
```

---

## 🗑️ Uninstallation

```bash
pkill -f spotify-adblock.sh
rm ~/.local/bin/spotify-adblock.sh
rm ~/.config/autostart/spotify-adblock.desktop
rm /tmp/spotify-adblock.lock
```

---

## ⚖️ Disclaimer

* No Spotify binaries are modified
* May violate Spotify Terms of Service
* Use at your own risk
