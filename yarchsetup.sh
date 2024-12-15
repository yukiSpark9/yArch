#!/bin/bash

# This script will install various packages and dependencies on an Arch-based system.

# Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install required packages from official repositories, including bottom and other utilities
echo "Installing official packages..."
sudo pacman -S --noconfirm kitty waybar git code neofetch krita gimp eyedropper slurp grim ttf-font-awesome bottom

# Clone the AUR helper repository (yay)
echo "Cloning AUR helper (yay)..."
git clone https://aur.archlinux.org/yay.git

# Enter the yay directory and build it
cd yay
echo "Building yay AUR helper..."
makepkg -si --noconfirm

# Install AUR packages using yay, including spotify-tui
echo "Installing AUR packages..."
yay -S --noconfirm brave blahaj hyfetch obs vesktop wlogout bitwarden nerd-fonts-complete-mono-glyphs spotify-tui

# Set the Kitty theme to Catppuccin-Frappe
echo "Setting Kitty theme to Catppuccin-Frappe..."
kitty +kitten themes --reload-in=all Catppuccin-Frappe

# Clone and install the Catppuccin KDE theme
echo "Cloning and installing Catppuccin KDE theme..."
git clone --depth=1 https://github.com/catppuccin/kde catppuccin-kde && cd catppuccin-kde
./install.sh

# Download the ASCII art image to the desired directory
echo "Downloading ASCIIyuki.png to ~/Downloads/images..."
mkdir -p ~/Downloads/images
curl -o ~/Downloads/images/ASCIIyuki.png "https://cdn.discordapp.com/attachments/776616264344928257/1317694113889521764/image0.jpg?ex=675f9dc6&is=675e4c46&hm=14d619bc5b34dec4b178074ed34101db764a0cd5de7358736a7135b63cb44594&"

# Add the alias to ~/.bashrc
echo "Adding alias to ~/.bashrc..."
echo "alias yukifetch='neofetch --kitty ~/Downloads/images/ASCIIyuki.png'" >> ~/.bashrc

# Apply the changes to .bashrc
echo "Running blahaj to apply changes to .bashrc..."
blahaj -c trans ~/.bashrc

echo "Installation complete!"
