#!/bin/bash

echo "Installing Spotify Ad Skipper..."

# Create necessary directories if they don't exist
mkdir -p ~/.local/bin
mkdir -p ~/.config/autostart

# Download the main script from GitHub
curl -sSL https://raw.githubusercontent.com/Petr200/Spotify-adblock-flatpak/main/spotify-skipper.sh -o ~/.local/bin/spotify-skipper.sh

# Make the script executable
chmod +x ~/.local/bin/spotify-skipper.sh

# Automatically create a .desktop file for autostart on boot
cat <<EOF > ~/.config/autostart/spotify-skipper.desktop
[Desktop Entry]
Type=Application
Name=Spotify Ad Skipper
Comment=Automatically skips Spotify ads in Flatpak
Exec=$HOME/.local/bin/spotify-skipper.sh
Icon=spotify
Terminal=false
Categories=Utility;
X-GNOME-Autostart-enabled=true
EOF

echo "Installation complete! Starting the script now..."

# Kill any previously running instance (useful if the user is updating)
pkill -f spotify-skipper.sh

# Start the script in the background
nohup ~/.local/bin/spotify-skipper.sh >/dev/null 2>&1 &

echo "Spotify Ad Skipper is now running in the background and will start automatically with your PC."
