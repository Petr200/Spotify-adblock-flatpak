# 🎵 Spotify Adblock — Flatpak Edition
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-FCC624.svg)](https://www.linux.org/)

> Automatically skips Spotify ads by restarting the Flatpak instance. No patching, no modified binaries — just smart monitoring.

A lightweight Bash script that detects audio advertisements in the Flatpak version of Spotify and skips them instantly.
Includes **single-instance protection** via `flock` so it safely runs in the background.

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
* ⚡ Event-driven — near-zero CPU usage
* 🔁 Automatic Spotify restart when an ad is detected
* 🔔 Desktop notifications via `libnotify`
* 🛡️ Single instance guaranteed via `flock`
* 🚀 Autostart on login support

---

## 📋 Prerequisites

### 1️⃣ Install Flatpak (if not installed)

#### Ubuntu / Debian
```bash
sudo apt install flatpak
```

#### Fedora
```bash
sudo dnf install flatpak
```

#### Arch / Manjaro
```bash
sudo pacman -S flatpak
```

---

### 2️⃣ Add Flathub repository
```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
```

---

### 3️⃣ Install Spotify (Flatpak)
```bash
flatpak install flathub com.spotify.Client
```

---

### 4️⃣ Install dependencies

#### Ubuntu / Debian / Mint / Pop!_OS
```bash
sudo apt update
sudo apt install playerctl libnotify-bin
```

#### Fedora
```bash
sudo dnf install playerctl libnotify
```

#### Arch / Manjaro
```bash
sudo pacman -S playerctl libnotify
```

#### openSUSE
```bash
sudo zypper install playerctl libnotify-tools
```

---

## 🚀 Installation

### Quick Install (One Command)
```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

---

### Manual Installation
```bash
git clone https://github.com/Petr200/Spotify-adblock-flatpak.git
cd Spotify-adblock-flatpak
chmod +x spotify-adblock.sh
./spotify-adblock.sh &
```

---

### What the Installer Does

* Downloads the script to `~/.local/bin/spotify-adblock.sh`
* Makes it executable
* Creates an autostart entry at `~/.config/autostart/spotify-adblock.desktop`
* Stops any previously running instance
* Starts the script in the background

---

## ⚙️ Configuration & Customization

### 🔕 Disable notifications

Edit the script:
```bash
~/.local/bin/spotify-adblock.sh
```

Comment out or remove the `notify-send` lines:
```bash
# notify-send ...
```

---

### 🪟 About `--minimized`

Spotify is restarted with:
```bash
flatpak run com.spotify.Client --minimized
```

| Environment       | Works?        |
| ----------------- | ------------- |
| Fedora KDE Plasma | ✅ Fully       |
| Fedora GNOME      | ✅ Usually     |
| Ubuntu GNOME      | ✅ Yes         |
| XFCE              | ⚠️ Sometimes  |
| i3 / sway         | ❌ Ignored     |

**Alternatives**

Always open the window:
```bash
flatpak run com.spotify.Client
```

i3 workaround — add to your i3 config:
```bash
for_window [class="Spotify"] move scratchpad
```

---

### 🛡️ Single instance protection

```bash
exec {LOCK_FD}>/tmp/spotify-adblock.lock
if ! flock -n "$LOCK_FD"; then
    notify-send -t 1600 -i com.spotify.Client -a "Spotify Adblock" "Already running"
    exit 1
fi
```

---

## 🔄 Updating

Re-run the installer to update to the latest version:
```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

---

## ⚙️ How It Works

1. Monitors Spotify metadata changes via `playerctl --follow`
2. Detects ads by checking if the track ID contains `spotify/ad`
3. Kills the Spotify Flatpak process
4. Restarts Spotify with `--minimized`
5. Waits until Spotify is fully loaded, then resumes playback
6. Prevents duplicate script instances via `flock`

---

## 🛠️ Troubleshooting

### Script downloaded incorrectly (404)
```bash
cat ~/.local/bin/spotify-adblock.sh
```

If you see `404: Not Found` → reinstall using the quick install command above.

---

### Check if Spotify Flatpak is installed
```bash
flatpak list | grep spotify
```

---

### Check if the script is running
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

Install a notification daemon:
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
* This script may violate Spotify's Terms of Service
* Use at your own risk
