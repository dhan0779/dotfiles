# dotfiles

Personal macOS dotfiles — Neovim and Ghostty.

```
dotfiles/
├── nvim/        # Neovim config  -> symlinked to ~/.config/nvim
├── ghostty/     # Ghostty config -> symlinked to ~/.config/ghostty/config
└── install.sh   # Fresh-machine bootstrap
```

## Fresh machine setup

```sh
git clone https://github.com/dhan0779/dotfiles.git ~/dotfiles
~/dotfiles/install.sh
```

`install.sh` will:

1. Install the Xcode Command Line Tools (compilers for treesitter / fzf-native).
2. Install Homebrew if missing.
3. Install dependencies: `neovim`, `git`, `ripgrep`, `fd`, `tree-sitter-cli`,
   plus the `ghostty` terminal and `font-jetbrains-mono-nerd-font` (icons).
4. Symlink `nvim/` and `ghostty/config` into `~/.config` (existing files are
   backed up to `*.backup`).
5. Add a `~/.zshrc` guard so Ghostty uses `TERM=xterm-ghostty` (colored
   underlines in nvim).

On first `nvim` launch, [lazy.nvim](https://github.com/folke/lazy.nvim)
bootstraps itself and installs all plugins automatically.

> **Note:** set your Ghostty font to a Nerd Font (e.g. JetBrainsMono Nerd Font)
> for icons to render.
