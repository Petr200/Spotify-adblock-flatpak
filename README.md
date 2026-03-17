# 🎧 Spotify Adblock Flatpak

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-4EAA25.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-FCC624.svg)](https://www.linux.org/)

A robust, ultra-lightweight Bash script for Linux that automatically detects and skips audio advertisements in the Flatpak version of Spotify. It works silently in the background, ensuring an uninterrupted listening experience without modifying the Spotify binary itself.

---

## 📑 Table of Contents
- [Key Features](#-key-features)
- [Prerequisites & Dependencies](#-prerequisites--dependencies)
- [Installation & Usage](#-installation--usage)
  - [Automated Installation](#option-a-automated-installation-recommended)
  - [Manual Installation](#option-b-detailed-manual-installation)
- [Updating the Script](#-updating)
- [How It Works (Under the Hood)](#-how-it-works-under-the-hood)
- [Troubleshooting & FAQ](#️-troubleshooting--faq)
- [Uninstallation](#-uninstallation)
- [Contributing](#-contributing)
- [License & Disclaimer](#️-license--disclaimer)

---

## ✨ Key Features

* **Zero Modifications:** Does not alter Spotify's core files, avoiding potential account bans or breaking updates.
* **Minimal Resource Usage:** Relies on event-driven MPRIS metadata tracking (`playerctl --follow`) rather than heavy CPU polling.
* **Seamless Resumption:** Instantly kills the client upon ad detection and restarts it minimized, immediately playing the next track in your queue.
* **Smart Loop Prevention:** Checks the last played song to ensure it doesn't get stuck in an endless restart loop if Spotify struggles to load.
* **Set-and-Forget:** Includes an automated installer that sets up the script to run quietly on system boot.
* **Native Notifications:** Integrates with your desktop environment to let you know exactly when an ad was intercepted.

---

## 📋 Prerequisites & Dependencies

Before running the script, ensure you have the **Flatpak version of Spotify** installed. If you installed Spotify via `apt`, `pacman`, or `snap`, this specific script will not work.

The script also relies on `playerctl` to read Spotify's metadata and `libnotify` to display native desktop notifications. Install the required dependencies based on your Linux distribution:

**Ubuntu, Pop!_OS, Linux Mint, Debian:**
```bash
sudo apt update
sudo apt install playerctl libnotify-bin
