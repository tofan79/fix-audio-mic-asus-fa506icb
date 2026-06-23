#!/bin/bash
# Install audio/mic fix for ASUS TUF A15 FA506ICB (ALC256)
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ":: Installing ASUS TUF A15 FA506ICB audio fixes..."

# WirePlumber soft-mixer
mkdir -p ~/.config/wireplumber/wireplumber.conf.d/
cp "$SCRIPT_DIR/alsa-soft-mixer.conf" ~/.config/wireplumber/wireplumber.conf.d/

# Fix script
mkdir -p ~/.local/bin
cp "$SCRIPT_DIR/fix-asus-audio.sh" ~/.local/bin/
chmod +x ~/.local/bin/fix-asus-audio.sh

# Systemd services
mkdir -p ~/.config/systemd/user
cp "$SCRIPT_DIR/fix-asus-audio.service" ~/.config/systemd/user/
cp "$SCRIPT_DIR/fix-audio-watcher.service" ~/.config/systemd/user/

# Enable
systemctl --user daemon-reload
systemctl --user enable --now fix-asus-audio.service
systemctl --user enable --now fix-audio-watcher.service

# Apply now
~/.local/bin/fix-asus-audio.sh

echo ":: Done. Mic & audio fixed."
