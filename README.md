# Spotify Adblock Flatpak

A lightweight Bash script for Linux that automatically detects and skips Spotify ads in the Flatpak version by restarting the client.

---

## 🚀 How it works
The script monitors Spotify's metadata via `playerctl`. When an advertisement is detected (track ID containing `spotify/ad`), the script automatically:
* **Terminates** the Spotify Flatpak process.
* **Restarts** the client in the background (minimized).
* **Resumes** playback of the next actual song.

## 📋 Prerequisites
To run this script, you need to have the following installed:

| Tool | Purpose |
| :--- | :--- |
| **Spotify** | Must be the [Flatpak version](https://flathub.org/apps/details/com.spotify.Client) |
| **playerctl** | To monitor and control media playback |
| **libnotify** | To display desktop notifications |

## 🛠 Installation & Usage

1.  **Clone the repository:**
    ```bash
    git clone [https://github.com/Petr200/Spotify-adblock-flatpak.git](https://github.com/Petr200/Spotify-adblock-flatpak.git)
    cd Spotify-adblock-flatpak
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x spotify-skipper.sh
    ```

3.  **Run the script:**
    ```bash
    ./spotify-skipper.sh
    ```

## 📝 Script Details
The script is designed for the `com.spotify.Client` Flatpak ID. It uses a loop to follow MPRIS metadata changes, ensuring minimal CPU usage while providing instant ad skipping.

## ⚖️ License
This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

---
> **Disclaimer:** This script is for educational purposes only. It is not affiliated with or endorsed by Spotify.
