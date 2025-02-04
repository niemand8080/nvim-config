# Nvim Config

Run this to update the neovim config.

```bash
#!/bin/bash

BRANCH="main"

GIT_URL="https://github.com/niemand8080/nvim-config"
REPO_DIR="$HOME/.vim/nvim-config"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

mkdir -p "$HOME/.vim"

if [[ ! -d "$REPO_DIR" ]]; then
    echo "Cloning neovim config repository"
    git clone "$GIT_URL" "$REPO_DIR"
else
    # Pull latest changes if repo exists
    cd "$REPO_DIR" || exit
    git fetch origin

    # Check for updates
    if git staus -uno | grep -q "Your branch is behind"; then
        echo "Updated found. Pulling latest changes"
        git pull origin "$BRANCH"
    else 
        echo "Neovim config already up to date."
        exit 0
    fi
fi

echo "Syncing neovim config..."
rsync -av --delete "$REPO_DIR/" "$NVIM_CONFIG_DIR/"

echo "Successfully updated neovim config!"
```
