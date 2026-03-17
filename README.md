# Spotify Ad Skipper (Flatpak)

A lightweight Bash script for Linux that automatically detects and skips Spotify ads in the Flatpak version by restarting the client.

---

## 🚀 How it works
The script uses `playerctl` to monitor Spotify's metadata. When it detects a track identified as an advertisement (e.g., containing `spotify/ad` in its ID), it instantly:
1. Kills the Spotify Flatpak process.
2. Restarts Spotify in the background (minimized).
3. Resumes playback automatically.

## 📋 Prerequisites
Make sure you have the following installed on your system:
* **Spotify** (installed via [Flatpak](https://flathub.org/apps/details/com.spotify.Client))
* **playerctl** (Command-line utility for controlling media players)
* **libnotify** (Optional, for desktop notifications)

## 🛠 Installation

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/spotify-adblock-flatpak.git](https://github.com/your-username/spotify-adblock-flatpak.git)
   cd spotify-adblock-flatpak
   
