#!/bin/bash

# This script installs various packages and dependencies on an Arch-based system.

echo "Starting the installation script..."

# Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install required packages from official repositories
echo "Installing official packages..."
sudo pacman -S --noconfirm kitty waybar git code neofetch krita gimp eyedropper slurp grim ttf-font-awesome bottom

# Clone the AUR helper repository (yay) if it doesn't exist
if [ ! -d yay ]; then
    echo "Cloning AUR helper (yay)..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    echo "Building yay AUR helper..."
    makepkg -si --noconfirm
    cd ..
else
    echo "Yay is already cloned and installed."
fi

# Install AUR packages using yay
echo "Installing AUR packages..."
yay -S --noconfirm brave blahaj hyfetch obs vesktop wlogout bitwarden nerd-fonts-complete-mono-glyphs spotify-tui

# Set the Kitty theme to Catppuccin-Frappe
echo "Setting Kitty theme to Catppuccin-Frappe..."
kitty +kitten themes --reload-in=all Catppuccin-Frappe

# Clone and install the Catppuccin KDE theme
if [ ! -d catppuccin-kde ]; then
    echo "Cloning and installing Catppuccin KDE theme..."
    git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde
    cd catppuccin-kde
    ./install.sh
    cd ..
else
    echo "Catppuccin KDE theme is already installed."
fi

# Download the ASCII art image
ASCII_IMAGE_PATH=~/Downloads/images/ASCIIyuki.png
if [ ! -f "$ASCII_IMAGE_PATH" ]; then
    echo "Downloading ASCIIyuki.png to ~/Downloads/images..."
    mkdir -p ~/Downloads/images
    curl -o "$ASCII_IMAGE_PATH" "https://cdn.discordapp.com/attachments/776616264344928257/1317694113889521764/image0.jpg"
else
    echo "ASCIIyuki.png already exists."
fi

# Add the alias to ~/.bashrc if not already present
if ! grep -q "alias yukifetch" ~/.bashrc; then
    echo "Adding alias to ~/.bashrc..."
    echo "alias yukifetch='neofetch --kitty ~/Downloads/images/ASCIIyuki.png'" >> ~/.bashrc
else
    echo "Alias yukifetch already exists in ~/.bashrc."
fi

# Add Waybar to the autostart menu
AUTOSTART_DIR=~/.config/autostart
AUTOSTART_FILE=$AUTOSTART_DIR/waybar.desktop
if [ ! -f "$AUTOSTART_FILE" ]; then
    echo "Adding Waybar to autostart..."
    mkdir -p "$AUTOSTART_DIR"
    cat <<EOF > "$AUTOSTART_FILE"
[Desktop Entry]
Type=Application
Exec=waybar
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Waybar
EOF
else
    echo "Waybar is already in the autostart menu."
fi

echo "Installation script complete!"
