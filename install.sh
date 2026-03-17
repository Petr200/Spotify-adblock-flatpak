#!/bin/bash
# ================================
# Spotify Adblock Installer
# ================================

echo "Installing Spotify Adblock..."

# Create necessary directories
mkdir -p ~/.local/bin
mkdir -p ~/.config/autostart

# Download the main script (Spotify-adblock.sh) from repo
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/Spotify-adblock.sh -o ~/.local/bin/Spotify-adblock.sh

# Make it executable
chmod +x ~/.local/bin/Spotify-adblock.sh

# Create autostart .desktop file
cat <<EOF > ~/.config/autostart/spotify-adblock.desktop
[Desktop Entry]
Type=Application
Name=Spotify Adblock
Comment=Automatically skips Spotify ads in Flatpak
Exec=$HOME/.local/bin/Spotify-adblock.sh
Icon=spotify
Terminal=false
Categories=Utility;
X-GNOME-Autostart-enabled=true
EOF

# Kill any previous running instance
pkill -f Spotify-adblock.sh 2>/dev/null

# Start the script in the background
nohup ~/.local/bin/Spotify-adblock.sh >/dev/null 2>&1 &

echo "Installation complete! Spotify Adblock is running in the background and will start automatically with your PC."

# ================================
# Optional: install dependencies
# ================================
echo ""
echo "Make sure the following packages are installed:"
echo "Ubuntu/Debian: sudo apt install playerctl libnotify-bin"
echo "Fedora: sudo dnf install playerctl libnotify"
echo "Arch/Manjaro: sudo pacman -S playerctl libnotify"
echo "openSUSE: sudo zypper install playerctl libnotify-tools"
echo ""
echo "Done!"
