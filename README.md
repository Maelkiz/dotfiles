# Dotfiles

This is a bare repo containing my dekstop environment agnostic configuration files.

---

> ### ⚠️ Warning!
> The provided installation instructions might **overwrite existing files in your `$HOME` directory**.
> If you have existing configs you don't want to lose, make sure to back them up first.

---

## Prerequisites

The setup assumes the following are installed on your system:
```console
ttf-jetbrains-mono-nerd \
ghostty \
starship \
fish \
code \
bash \
git \
vim \
eza \
```

---

## Installation and Setup

One-liner to install the bare repo (overrides existing config files):
```fish
git clone --bare https://github.com/Maelkiz/dotfiles.git "$HOME/.dotfiles" && \
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" checkout -f && \
git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" config --local status.showUntrackedFiles no
```

Convenient alias (included in the fish config):
```fish
alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
```

It lets you use interact with the bare repo like this:
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
