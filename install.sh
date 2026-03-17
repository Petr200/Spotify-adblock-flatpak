#!/bin/bash
# ================================
# Spotify Adblock Installer
# ================================

echo "Installing Spotify Adblock..."

# Create necessary directories
mkdir -p ~/.local/bin
mkdir -p ~/.config/autostart

# Download the main script (spotify-adblock.sh) from repo
# Přidáno -f proti 404 chybám a opraveno na malé "s" v URL
curl -f -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/spotify-adblock.sh -o ~/.local/bin/spotify-adblock.sh

# Make it executable
chmod +x ~/.local/bin/spotify-adblock.sh

# Create autostart .desktop file
# Opraveno Exec= na malé "s", aby se to po startu PC opravdu našlo
cat <<EOF > ~/.config/autostart/spotify-adblock.desktop
[Desktop Entry]
Type=Application
Name=Spotify Adblock
Comment=Automatically skips Spotify ads in Flatpak
Exec=$HOME/.local/bin/spotify-adblock.sh
Icon=spotify
Terminal=false
Categories=Utility;
X-GNOME-Autostart-enabled=true
EOF

# Kill any previous running instance (|| true zabrání chybě, pokud nic neběží)
pkill -f spotify-adblock.sh 2>/dev/null || true

# Start the script in the background
nohup ~/.local/bin/spotify-adblock.sh >/dev/null 2>&1 &

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
