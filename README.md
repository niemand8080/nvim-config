# Nvim Config

## Instalation

Run this to update the neovim config.

### NPM

Make sure you have npm installed, so [Mason](https://github.com/williamboman/mason.nvim) can install LSP's.

```
npm --version
```

To install npm visit the [NodeJs](https://nodejs.org/en/download) website.

### Ripgrep
Also make sure that you have ripgrep installed.

```
rg --version
```
#### Install ripgrep with:

Homebew
```
brew install ripgrep
```

apt
```
sudo apt-get install ripgrep
```

### Update Script

Run this update srcipt to update your nvim config.

```bash
#!/bin/bash

BRANCH="main"

GIT_URL="https://github.com/niemand8080/nvim-config"
REPO_DIR="$HOME/.vim/config/nvim-config"
OLD_CONFIG_DIR="$HOME/.vim/config/old"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

mkdir -p "$OLD_CONFIG_DIR"

if [[ ! -d "$REPO_DIR" ]]; then
    echo "Cloning neovim config repository"
    git clone "$GIT_URL" "$REPO_DIR"
    echo "Coping your current nvim config to $OLD_CONFIG_DIR" 
    cp "$NVIM_CONFIG_DIR" "$OLD_CONFIG_DIR"
else
    # Pull latest changes if repo exists
    cd "$REPO_DIR" || exit
    git fetch origin
    
    # Check for updates
    if git status -uno | grep -q "Your branch is behind"; then
        echo "Updated found. Pulling latest changes"
        git pull origin "$BRANCH"
    else 
        echo "Neovim config already up to date."
        exit 0
    fi
fi

echo "Syncing neovim config..."
rsync -av --delete "$REPO_DIR/src/" "$NVIM_CONFIG_DIR/"

echo "Successfully updated neovim config!"
```

## Trubelshooting

Make sure you have installed npm and a C compiler like gcc.
