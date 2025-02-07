# Nvim Config

## Instalation

Run this to update the neovim config.

### Requirements

[neovim >=0.9.0](https://github.com/neovim/neovim/wiki/)

#### NPM

Make sure you have npm installed, so [Mason](https://github.com/williamboman/mason.nvim) can install LSP's.

```
npm --version
```

To install npm visit the [NodeJs](https://nodejs.org/en/download) website.

#### Ripgrep

Also make sure that you have ripgrep installed.

```
rg --version
```
##### Install ripgrep with:

Homebew
```
brew install ripgrep
```

apt
```
sudo apt-get install ripgrep
```

#### Nerd Fonts

[Nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) is optional. It uses [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) which is optional too and used to display file icons. It requires a [nerd font](https://www.nerdfonts.com/). Your terminal emulator must be configured to use that font, usually "Hack Nerd Font"

##### Install Nerdfonts

Homebrew

```
brew install --cask font-hack-nerd-font
```

Apt

```
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget -O "Hack.zip" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"
unzip Hack.zip
rm Hack.zip
fc-cache -fv
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

## Troubleshooting

Make sure you have installed npm and a C compiler like gcc.

If you have an error like this:

```error
Failed to run config for telescope.nvim

...m/lazy/telescope.nvim/lua/telescope/_extensions/init.lua:10: 'fzf' extension doesn't exist or isn't installed: ...
hare/nvim/lazy/telescope-fzf-native.nvim/lua/fzf_lib.lua:11: /home/niemand/.local/share/nvim/lazy/telescope-fzf-nativ
e.nvim/lua/../build/libfzf.so: cannot open shared object file: No such file or directory

# stacktrace:
  - /telescope.nvim/lua/telescope/_extensions/init.lua:10 _in_ **load_extension**
  - /telescope.nvim/lua/telescope/_extensions/init.lua:62 _in_ **load_extension**
  - ~/.config/nvim/lua/b2/lazy/telescope.lua:26 _in_ **config**
  - ~/.config/nvim/lua/b2/init_lazy.lua:19
  - ~/.config/nvim/lua/b2/init.lua:2
  - ~/.config/nvim/init.lua:1
```

You may have to compile the fzf by doing the following:

```
cd ~/.local/share/nvim/lazy/telescope-fzf-native.nvim

# Compile
make
```

## Image support

To support image follow the guide [here](https://github.com/3rd/image.nvim).
