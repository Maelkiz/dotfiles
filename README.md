# Dotfiles

This is a bare repo containing my configs for a [niri](https://github.com/YaLTeR/niri) + [Noctalia](https://github.com/noctalia-dev/noctalia) desktop, which I am currently daily-driving on a thinkpad running [CachyOS](https://cachyos.org/).

---

## Prerequisites

The setup assumes the following are installed on your system (package names might vary by distro):
```console
paru -S --needed \
  niri noctalia xwayland-satellite polkit-gnome \
  kitty fish starship \
  ttf-jetbrains-mono-nerd ttf-meslo-nerd \
  wl-clipboard wl-mirror jq \
  brave-bin nautilus visual-studio-code-bin \
  neovim vim eza btop cava fastfetch \
  bibata-cursor-theme adw-gtk-theme papirus-icon-theme qt6ct
```

The Neovim config (based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim)) additionally needs:
```console
neovim \
ripgrep \
fd \
make \
gcc \
unzip \
tree-sitter-cli
```

VS Code uses the [One Dark Pro](https://marketplace.visualstudio.com/items?itemName=zhuangtongfa.Material-theme) theme extension:
```fish
code --install-extension zhuangtongfa.material-theme
```

Noctalia generates the colour themes for niri, kitty, ghostty, GTK, Qt, btop, cava, starship and Neovim from the current palette, so those files change whenever the wallpaper or colour scheme does.

---

## Installation and Setup

> ### ⚠️ Warning!
> The provided installation instructions might overwrite existing files in your `$HOME` directory.
> If you have existing configs you don't want to lose, make sure to back them up first.

One-liner to install the bare repo (overrides existing config files):
```fish
git clone --bare https://github.com/Maelkiz/dotfiles.git "$HOME/.dotfiles" && \
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout -f && \
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config --local status.showUntrackedFiles no
```

Optionally, remove this README from `$HOME` without git seeing it as deleted:
```fish
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" sparse-checkout set --no-cone '/*' '!/README.md'
```

Convenient alias (included in the fish and bash configs):
```fish
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

It lets you interact with the bare repo like this:
```fish
dotfiles status
dotfiles add ~/.bashrc
dotfiles commit -m "Update bash config"
dotfiles push
```

Instead of like this:
```fish
git --git-dir=$HOME/.dotfiles --work-tree=$HOME status
git --git-dir=$HOME/.dotfiles --work-tree=$HOME add ~/.bashrc
git --git-dir=$HOME/.dotfiles --work-tree=$HOME commit -m "Update bash config"
git --git-dir=$HOME/.dotfiles --work-tree=$HOME push
```
