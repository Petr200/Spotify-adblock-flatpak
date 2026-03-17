# 🎧 Spotify Adblock Flatpak

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-FCC624.svg)](https://www.linux.org/)

A robust, ultra-lightweight Bash script for Linux that automatically detects and skips audio advertisements in the Flatpak version of Spotify. It works silently in the background, ensuring an uninterrupted listening experience without modifying the Spotify binary itself.

---

## 📑 Table of Contents

* [Key Features](#-key-features)
* [Prerequisites & Dependencies](#-prerequisites--dependencies)
* [Installation & Usage](#-installation--usage)

  * [Automated Installation](#option-a-automated-installation-recommended)
  * [Manual Installation](#option-b-detailed-manual-installation)
* [Updating the Script](#-updating)
* [How It Works (Under the Hood)](#-how-it-works-under-the-hood)
* [Troubleshooting & FAQ](#️-troubleshooting--faq)
* [Uninstallation](#-uninstallation)
* [Contributing](#-contributing)
* [License & Disclaimer](#️-license--disclaimer)

---

## ✨ Key Features

* **Zero Modifications:** Does not alter Spotify's core files, avoiding potential account bans or breaking updates.
* **Minimal Resource Usage:** Uses event-driven MPRIS metadata tracking (`playerctl --follow`) instead of heavy CPU polling.
* **Seamless Resumption:** Instantly kills the client when an ad is detected and relaunches it minimized.
* **Smart Loop Prevention:** Prevents endless restart loops if Spotify fails to load properly.
* **Set-and-Forget:** Optional auto-start setup on system boot.
* **Native Notifications:** Shows desktop notifications when an ad is skipped.

---

## 📋 Prerequisites & Dependencies

Make sure you are using the **Flatpak version of Spotify (`com.spotify.Client`)**.

Install required dependencies:

### Ubuntu, Pop!_OS, Linux Mint, Debian

```bash
sudo apt update
sudo apt install playerctl libnotify-bin
```

### Fedora

```bash
sudo dnf install playerctl libnotify
```

### Arch Linux, Manjaro, EndeavourOS

```bash
sudo pacman -S playerctl libnotify
```

---

# 🚀 Installation & Usage

## Option A: Automated Installation (Recommended)

Run:

```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

---

## Option B: Detailed Manual Installation

### 1. Clone the repository

```bash
git clone https://github.com/Petr200/Spotify-adblock-flatpak.git
cd Spotify-adblock-flatpak
```

### 2. Make the script executable

```bash
chmod +x spotify-skipper.sh
```

### 3. Test the script

```bash
./spotify-skipper.sh
```

(Open Spotify, play music, wait for an ad. Stop with `Ctrl + C`.)

### 4. Run in background

```bash
nohup ./spotify-skipper.sh >/dev/null 2>&1 &
```

---

# 🔄 Updating

```bash
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/install.sh | bash
```

---

# ⚙️ How It Works (Under the Hood)

* **Monitoring:** `playerctl --follow`
* **Detection:** Looks for `spotify/ad` in track ID
* **Execution:**

  ```bash
  flatpak kill com.spotify.Client
  ```
* **Recovery:** Relaunches Spotify minimized
* **Resume:** Waits and resumes playback if paused

---

# 🛠️ Troubleshooting & FAQ

### Ads are not skipping

```bash
flatpak list | grep spotify
```

Ensure `com.spotify.Client` appears.

---

### Spotify opens in foreground

Some desktop environments ignore `--minimized`.

---

### No notifications

Install a notification daemon (`dunst`, `mako`, etc.).

---

### Is it safe?

Yes. No modification of Spotify binaries or account data.

---

# 🗑️ Uninstallation

```bash
pkill -f spotify-skipper.sh
rm ~/.local/bin/spotify-skipper.sh
rm ~/.config/autostart/spotify-skipper.desktop
```

---

# 🤝 Contributing

Pull requests and issues are welcome.

---

# ⚖️ License & Disclaimer

MIT License.

**Disclaimer:**
This project is for educational purposes only and is not affiliated with Spotify AB. Use at your own risk.
