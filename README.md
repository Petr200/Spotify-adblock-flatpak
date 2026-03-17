# 🎧 Spotify Adblock Flatpak

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-FCC624.svg)](https://www.linux.org/)

> Skip Spotify ads instantly on Linux (Flatpak) with near-zero CPU usage.

A lightweight Bash script that automatically detects and skips audio advertisements in the Flatpak version of Spotify.

---

## ✨ Features

* 🚫 No Spotify binary modification
* ⚡ Event-driven (almost zero CPU usage)
* 🔁 Automatic restart when ads are detected
* 🔕 Optional notifications
* 🚀 Autostart support

---

## 📋 Requirements

### Spotify (Flatpak)

```bash
flatpak install flathub com.spotify.Client
```

---

## 📦 Dependencies (by distro)

### 🟢 Ubuntu / Debian / Linux Mint / Pop!_OS

```bash
sudo apt update
sudo apt install playerctl libnotify-bin
```

---

### 🔵 Fedora

```bash
sudo dnf install playerctl libnotify
```

> ℹ️ Notifications work out-of-the-box on Fedora GNOME (Wayland)

---

### ⚫ Arch Linux / Manjaro / EndeavourOS

```bash
sudo pacman -S playerctl libnotify
```

---

### 🟣 openSUSE

```bash
sudo zypper install playerctl libnotify-tools
```

---

### 🪟 Window managers (i3, sway, bspwm…)

You also need a notification daemon:

```bash
sudo pacman -S dunst   # Arch
sudo apt install dunst # Debian/Ubuntu
```

or:

```bash
sudo pacman -S mako    # Wayland
```

---

# 🚀 Installation

## Quick install

```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

---

## Manual install (from repo)

```bash
git clone https://github.com/Petr200/Spotify-adblock-flatpak.git
cd Spotify-adblock-flatpak

chmod +x spotify-skipper.sh
./spotify-skipper.sh
```

---

# ⚙️ How It Works

1. Listens to Spotify using:

```bash
playerctl --follow
```

2. Detects ads via:

```
spotify/ad
```

3. When ad is detected:

```bash
flatpak kill com.spotify.Client
flatpak run com.spotify.Client --minimized
```

4. Waits for restart and resumes playback

---

# ⚙️ Configuration

## 🔕 Disable notifications

Edit:

```bash
nano spotify-skipper.sh
```

Comment/remove:

```bash
notify-send ...
```

---

## 🪟 About `--minimized`

```bash
flatpak run com.spotify.Client --minimized
```

### Behavior depends on environment:

| Environment | Works             |
| ----------- | ----------------- |
| GNOME       | ✅ Yes             |
| KDE Plasma  | ✅ Yes*            |
| XFCE        | ⚠️ Mixed          |
| i3 / sway   | ❌ Usually ignored |

*Tested on Fedora KDE Plasma 

### Alternatives

#### Always open window:

```bash
flatpak run com.spotify.Client
```

#### WM rule example (i3):

```bash
for_window [class="Spotify"] move scratchpad
```

---

## 🔁 Ensure only one instance runs

### Lock file (recommended)

```bash
LOCKFILE="/tmp/spotify-skipper.lock"

if [ -e "$LOCKFILE" ]; then
    echo "Already running"
    exit 1
fi

trap "rm -f $LOCKFILE" EXIT
touch "$LOCKFILE"
```

---

# 🔔 Notifications

Uses:

```bash
notify-send
```

### Works out of the box on:

* ✅ GNOME (Ubuntu, Fedora)
* ✅ KDE (with notification service)
* ✅ XFCE

### Requires extra setup:

* ⚠️ i3 → install `dunst`
* ⚠️ Wayland → install `mako`

### Test notifications:

```bash
notify-send "Test" "It works!"
```

If nothing appears → missing notification daemon

---

# 🛠️ Troubleshooting

### Ads not skipping

```bash
flatpak list | grep spotify
```

---

### Script not running

```bash
ps aux | grep spotify-skipper
```

---

### Spotify opens in foreground

→ `--minimized` not supported by your DE

---

### Notifications not working

```bash
notify-send "Test"
```

---

# 🗑️ Uninstall

```bash
pkill -f spotify-skipper.sh
rm ~/.local/bin/spotify-skipper.sh
rm ~/.config/autostart/spotify-skipper.desktop
rm /tmp/spotify-skipper.lock
```

---

# ⚖️ Disclaimer

This project does not modify Spotify binaries.
However, it may violate Spotify Terms of Service.

Use at your own risk.
