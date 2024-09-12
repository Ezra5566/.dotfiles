#!/bin/bash

# Kali Linux Setup Script

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print colored output
print_color() {
    local color=$1
    local message=$2
    echo -e "\e[${color}m${message}\e[0m"
}

# Update sources list to include Kali repositories
print_color "33" "Updating sources list for Kali Linux..."
sudo tee /etc/apt/sources.list << EOF
deb http://http.kali.org/kali kali-rolling main non-free contrib
EOF

# Add Kali software key
print_color "33" "Adding Kali software key..."
sudo wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc

# Update and upgrade system to Kali
print_color "33" "Updating and upgrading to Kali Linux..."
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y kali-defaults

# Install Starship
print_color "33" "Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh

# Configure Starship in .bashrc
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# Create Starship configuration file
mkdir -p ~/.config && touch ~/.config/starship.toml

# Install dependencies
print_color "33" "Installing essential tools and dependencies..."
sudo apt update && sudo apt install -y \
  fzf \
  btop \
  bat \
  nodejs \
  npm \
  yarn \
  git \
  gh \
  zoxide \
  curl \
  wget \
  ripgrep \
  fastfetch \
  build-essential \
  python3 \
  python3-pip \
  xclip \
  openssh-client

# Install eza
print_color "33" "Installing eza..."
sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza

# Install Lazygit
print_color "33" "Installing Lazygit..."
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm lazygit lazygit.tar.gz

# Install Super File
print_color "33" "Installing Super File..."
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"

# Install Oh My Posh
print_color "33" "Installing Oh My Posh..."
curl -s https://ohmyposh.dev/install.sh | bash -s

# Set up bat
print_color "33" "Setting up bat..."
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat

# Git configuration
print_color "33" "Configuring Git..."
read -p "Enter your Git username: " git_username
read -p "Enter your Git email: " git_email

git config --global user.name "$git_username"
git config --global user.email "$git_email"
git config --global init.defaultBranch main

# Generate SSH key for GitHub
print_color "33" "Generating SSH key for GitHub..."
ssh-keygen -t ed25519 -C "$git_email"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Display the public key
print_color "32" "Your SSH public key (add this to your GitHub account):"
cat ~/.ssh/id_ed25519.pub

print_color "32" "Installation complete! Please restart your terminal or source your .bashrc file."
print_color "32" "Don't forget to add your SSH key to your GitHub account!"
