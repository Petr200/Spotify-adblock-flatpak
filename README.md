# 🎧 Spotify Adblock Flatpak

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-FCC624.svg)](https://www.linux.org/)

> Skip Spotify ads instantly on Linux (Flatpak) with near-zero CPU usage.

A lightweight Bash script that automatically detects and skips audio advertisements in the Flatpak version of Spotify.

Includes **single-instance protection** via `flock` so you can safely autostart it without duplicates.

---

## ✨ Features

* 🚫 No Spotify binary modification
* ⚡ Event-driven (almost zero CPU usage)
* 🔁 Automatic restart when ads are detected
* 🔕 Optional notifications
* 🛡️ Single instance guaranteed (`flock`)
* 🚀 Autostart support

---

## 📋 Requirements

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

# 🚀 Installation

## Quick install

```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

## Manual install (from repo)

```bash
git clone https://github.com/Petr200/Spotify-adblock-flatpak.git
cd Spotify-adblock-flatpak
chmod +x spotify-skipper.sh
./spotify-skipper.sh
```

---

# ⚙️ How It Works

1. **Listens to Spotify** using:

```bash
playerctl --follow
```

2. **Detects ads** via track IDs containing:

```text
spotify/ad
```

3. **Skips ads**:

```bash
flatpak kill com.spotify.Client
flatpak run com.spotify.Client --minimized
```

4. **Resumes playback** if paused.

5. **Single instance protection**:
   The script uses `flock` on `/tmp/spotify-adblock.lock` to prevent multiple copies from running.

---

# ⚙️ Configuration

## 🔕 Disable notifications

Edit `spotify-skipper.sh` and comment/remove lines with:

```bash
notify-send ...
```

## 🪟 About `--minimized`

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

### Alternatives

* Remove minimized → always open window:

```bash
flatpak run com.spotify.Client
```

* WM rule example (i3):

```bash
for_window [class="Spotify"] move scratchpad
```

---

## 🔁 Ensure only one instance

Already built-in using `flock`:

```bash
exec {LOCK_FD}>/tmp/spotify-adblock.lock
if ! flock -n "$LOCK_FD"; then
    notify-send -t 1600 -i com.spotify.Client -a "Spotify Adblock" "Script is already running."
    exit 1
fi
```

---

# 🔔 Notifications

* Works out-of-the-box on GNOME/KDE
* On tiling WMs / Wayland, install `dunst` or `mako`

Test notifications:

```bash
notify-send "Test" "Notifications are working!"
```

---

# 🛠️ Troubleshooting

* Ads not skipping:

```bash
flatpak list | grep spotify
```

* Script not running:

```bash
ps aux | grep spotify-skipper
```

* Spotify opens in foreground → `--minimized` ignored by your DE/WM

---

# 🗑️ Uninstall

```bash
pkill -f spotify-skipper.sh
rm ~/.local/bin/spotify-skipper.sh
rm ~/.config/autostart/spotify-skipper.desktop
rm /tmp/spotify-adblock.lock
```

---

# ⚖️ Disclaimer

* No Spotify binaries are modified
* May violate Spotify Terms of Service
* Use at your own risk
