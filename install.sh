#!/usr/bin/env bash
#
# Bootstrap a fresh macOS machine from these dotfiles (Neovim + Ghostty).
#
#   git clone https://github.com/dhan0779/dotfiles.git ~/dotfiles
#   ~/dotfiles/install.sh
#
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
info() { printf "\033[1;34m==>\033[0m %s\n" "$1"; }

# ---------------------------------------------------------------------------
# 1. Xcode Command Line Tools — provides git, make, and clang, which are
#    required to compile telescope-fzf-native and the treesitter parsers.
# ---------------------------------------------------------------------------
if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "Complete the Command Line Tools install dialog, then re-run this script."
  exit 1
fi

# ---------------------------------------------------------------------------
# 2. Homebrew
# ---------------------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  info "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [ -x /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"   # Apple Silicon
  elif [ -x /usr/local/bin/brew ]; then
    eval "$(/usr/local/bin/brew shellenv)"      # Intel
  fi
fi

# ---------------------------------------------------------------------------
# 3. Dependencies
# ---------------------------------------------------------------------------
info "Installing CLI tools..."
brew install \
  neovim \
  git \
  ripgrep \
  fd \
  tree-sitter-cli

info "Installing apps and fonts..."
brew install --cask \
  ghostty \
  font-jetbrains-mono-nerd-font

# ---------------------------------------------------------------------------
# 4. Symlink configs into ~/.config (backs up anything already there)
# ---------------------------------------------------------------------------
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

link "$DOTFILES_DIR/nvim"          "$HOME/.config/nvim"
link "$DOTFILES_DIR/ghostty/config" "$HOME/.config/ghostty/config"

# ---------------------------------------------------------------------------
# 5. Make Ghostty use its own terminfo so colored underlines render in nvim
#    (otherwise TERM=xterm and underlines fall back to the foreground color).
# ---------------------------------------------------------------------------
ZSHRC="$HOME/.zshrc"
MARKER="# dotfiles: ghostty terminfo"
if [ -f "$ZSHRC" ] && ! grep -qF "$MARKER" "$ZSHRC"; then
  info "Adding Ghostty terminfo guard to ~/.zshrc"
  cat >> "$ZSHRC" <<'EOF'

# dotfiles: ghostty terminfo — enables colored underlines (guisp) in nvim
if [[ "$TERM_PROGRAM" == "ghostty" ]] && infocmp xterm-ghostty &>/dev/null; then
  export TERM=xterm-ghostty
fi
EOF
fi

info "Done. Open a new Ghostty window and launch nvim — plugins install on first run."
