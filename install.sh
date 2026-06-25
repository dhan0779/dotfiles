#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }

if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "Complete the Command Line Tools install dialog, then re-run this script."
  exit 1
fi

if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

info "Installing CLI tools..."
brew install \
  neovim \
  git \
  ripgrep \
  fd \
  tree-sitter-cli

install_cask() {
  local cask="$1"
  if brew list --cask "$cask" &>/dev/null; then
    brew upgrade --cask "$cask" || true
  elif ! brew install --cask "$cask" 2>/dev/null; then
    info "Skipping $cask (already present outside Homebrew)"
  fi
}

info "Installing apps and fonts..."
install_cask ghostty
install_cask font-jetbrains-mono-nerd-font

link() {
  local src="$1" dest="$2"
  mkdir -p "$(dirname "$dest")"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    info "Backing up existing $dest -> ${dest}.backup"
    mv "$dest" "${dest}.backup"
  fi
  ln -sfn "$src" "$dest"
  info "Linked $dest -> $src"
}

link "$DOTFILES_DIR/nvim"           "$HOME/.config/nvim"
link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"
link "$DOTFILES_DIR/zshrc"          "$HOME/.zshrc"
link "$DOTFILES_DIR/gitconfig"      "$HOME/.gitconfig"

if [ ! -f "$HOME/.zshrc.local" ]; then
  info "No ~/.zshrc.local found — creating a blank one for machine-local overrides"
  touch "$HOME/.zshrc.local"
fi

if [ ! -f "$HOME/.gitconfig.local" ]; then
  info "No ~/.gitconfig.local found — creating a blank one for machine-local overrides"
  touch "$HOME/.gitconfig.local"
fi

info "Done. Run 'source ~/.zshrc' and launch nvim."
