Here’s an updated version of the `README.md` that includes Git and GitHub setup, along with installing all dependencies mentioned in previous conversations:

# .dotfiles

This repository contains my configuration files for setting up a development and cybersecurity environment on a Chromebook using Kali Linux. Below is a breakdown of my setup process and configuration.

## 1. Terminal Configuration

### Switching from Debian to Kali Linux

I initially set up Kali Linux on my Chromebook, which uses Debian (Bookworm) by default.

```bash
# 1. Edit the sources list to include Kali repositories
sudo vim /etc/apt/sources.list

```

Change the contents to:
```plaintext
deb http://http.kali.org/kali kali-rolling main non-free contrib
```
Comment out the default Debian sources.

```bash
# 2. Add the Kali software key
sudo wget https://archive.kali.org/archive-key.asc -O /etc/apt/trusted.gpg.d/kali-archive-keyring.asc
```

```bash
# 3. Update and upgrade your system to Kali
sudo apt update && sudo apt full-upgrade
sudo apt install kali-defaults
```

### Setting Up the Terminal

#### Install Warp Terminal and Starship Prompt

```bash
# 1. Install Starship at the root to avoid entering the root password
curl -sS https://starship.rs/install.sh | sh
```

```bash
# 2. Configure Starship in your .bashrc
eval "$(starship init bash)"
```

```bash
# 3. Create the Starship configuration file
mkdir -p ~/.config && touch ~/.config/starship.toml
```
Customize your `starship.toml` as needed.

### Installing Dependencies

```bash

# Install essential tools for development, cybersecurity, and terminal customization
sudo apt update && sudo apt install -y \
  fzf \
  btop \
  bat \
  eza \
  yq \
  nodejs \
  npm \
  golang-go \
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
```

### Setting Up Git and GitHub

1. Set up global Git configurations:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "youremail@example.com"
   git config --global init.defaultBranch main
   ```

2. Set up SSH for GitHub:
   ```bash
   # Generate a new SSH key
   ssh-keygen -t ed25519 -C "youremail@example.com"

   # Add your SSH key to the ssh-agent
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519

   # Copy the SSH key to your clipboard
   xclip -selection clipboard < ~/.ssh/id_ed25519.pub
   ```

3. Add the SSH key to your GitHub account:
   - Go to [GitHub SSH Settings](https://github.com/settings/ssh/new) and paste your SSH key.

4. Verify your GitHub connection:
   ```bash
   ssh -T git@github.com
   ```

### Cloning Dotfiles from GitHub

1. Clone your dotfiles repository:
   ```bash
   git clone git@github.com:Ezra5566/.dotfiles.git
   ```

2. Symlink relevant files for your configurations:
   ```bash
   ln -sf ~/dotfiles/starship.toml ~/.config/starship.toml
   ln -sf ~/dotfiles/superfile/config.toml ~/.config/superfile/config.toml
   ln -sf ~/dotfiles/nvim ~/.config/nvim
   ```

## 2. Other Configurations and Installations

### Eza
To install `eza` (an improved version of `ls`):

```bash
sudo apt update
sudo apt install -y gpg
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt update
sudo apt install -y eza
```

### Lazygit
```bash
# Download and install lazygit
wget https://github.com/jesseduffield/lazygit/releases/download/v0.43.1/lazygit_0.43.1_Linux_x86_64.tar.gz
tar -xvf lazygit_0.43.1_Linux_x86_64.tar.gz
sudo mv lazygit /usr/local/bin/
rm lazygit_0.43.1_Linux_x86_64.tar.gz

# Verify installation
lazygit --version
```

### Super File
Install `Super File`:
```bash
bash -c "$(curl -sLo- https://superfile.netlify.app/install.sh)"
```

### Oh My Posh (for Nerd Fonts)
```bash
# Install oh-my-posh for Nerd Fonts
curl -s https://ohmyposh.dev/install.sh | bash -s
```

### Configure Nerd Fonts on Default Terminal
Ensure your terminal is set to use Nerd Fonts for optimal visual display of prompts.

### Bat
Set up `bat`:
```bash
mkdir -p ~/.local/bin
ln -s /usr/bin/batcat ~/.local/bin/bat
```

### Git Configuration
Set up individual git configurations based on your personal preferences.

---

This configuration file serves as a guide for quickly setting up a development environment on Kali Linux with essential tools, customized terminal experience, and Git/GitHub integration.


This updated version includes your Git and GitHub setup, SSH key generation, and all dependencies mentioned in previous conversations. Let me know if you'd like any further changes!
 
# Neovim Installation Guide

This guide will walk you through the process of installing Neovim (including the AppImage option) and FUSE, and making Neovim globally accessible on your system.

## Installing Neovim

### AppImage (Linux)

1. Download the latest Neovim AppImage:
   ```bash
   curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
   ```

2. Make the AppImage executable:
   ```bash
   chmod u+x nvim.appimage
   ```

3. Move the AppImage to a directory in your PATH, for example:
   ```bash
   sudo mv nvim.appimage /usr/local/bin/nvim
   ```

Note: AppImage requires FUSE to run. If you encounter issues, you may need to install FUSE or use the `--appimage-extract` option to run without FUSE.


## Installing FUSE

### Ubuntu/Debian

1. Install FUSE:
     [NOTE] remener to install fuse before installation even though not necessary
   ```bash
   sudo apt install fuse
   ```
## Making Neovim Global

### Linux and macOS

1. If you're using the AppImage, you've already made Neovim global by moving it to /usr/local/bin.
   ```
   what are you copying?? you already moved it to ...
   ```
2. Reload your shell configuration:
   ```bash
   source ~/.bashrc

   ```

   added a few new features like tmux

  how it looks like
```bash
.
├── aliases
│   └── .bash_aliases
├── bashrc
│   └── .bashrc
├── bck_install.sh
├── fastfetch
│   └── .config
│       └── fastfetch
├── fish
│   └── .config
│       └── fish
├── lazygit
│   └── .config
│       └── lazygit
├── nvim
│   └── .config
│       └── nvim
├── README.md
├── sesh
│   └── .config
│       └── sesh
├── starship
│   └── .config
│       └── starship.toml
├── superfile
│   └── .config
│       └── superfile
├── tmux
│   └── .config
│       └── tmux
└── vim
    └── .vimrc

27 directories, 6 files

```
