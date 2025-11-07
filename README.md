# Dotfiles

Cross-platform dotfiles for macOS and Linux with modular shell configurations supporting Fish, Bash, Zsh, and Nushell.

## Features

- **OS-aware configuration**: Single repository with automatic OS detection
- **Multi-shell support**: Equivalent environment variables across Fish, Bash, Zsh, and Nushell
- **Modular design**: Numbered prefix system for load order and organization
- **Secrets management**: Template-based secrets with gitignored actual values
- **GNU Stow**: Clean symlinking with automatic installation

## Quick Start

### macOS

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
make install
```

This will:
1. Install GNU Stow via Homebrew (if not present)
2. Symlink all dotfiles to your home directory
3. Create secrets templates in the appropriate locations

### Linux

```bash
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles
make install
```

This will:
1. Install GNU Stow via apt (if not present)
2. Symlink all dotfiles to your home directory
3. Create secrets templates in the appropriate locations

### Setting Up Secrets

After installation, you'll need to configure your secrets:

1. **Fish**: Edit `~/.config/fish/conf.d/99-secrets.fish`
2. **Bash**: Edit `~/.bashrc.d/99-secrets.bash`
3. **Zsh**: Edit `~/.zshrc.d/99-secrets.zsh`
4. **Nushell**: Edit `~/.config/nushell/env.d/99-secrets.nu`

Replace template placeholders with your actual credentials.

## Directory Structure

```
dotfiles/
├── Makefile                 # OS detection and dispatch
├── Makefile.darwin          # macOS-specific installation
├── Makefile.linux           # Linux-specific installation
├── bash/
│   ├── dot-bashrc           # Main bashrc (sources .bashrc.d/)
│   └── bashrc.d/
│       ├── 00-env.bash               # Common environment variables
│       ├── 01-env-darwin.bash        # macOS-specific (Homebrew paths)
│       ├── 01-env-linux.bash         # Linux-specific paths
│       ├── 10-interactive.bash       # Interactive shell tools
│       ├── 99-secrets.bash           # Actual secrets (gitignored)
│       └── 99-secrets.bash.template  # Template for secrets
├── fish/
│   └── dot-config/fish/
│       ├── config.fish      # Main config (auto-sources conf.d/)
│       └── conf.d/
│           ├── 00-env.fish               # Common environment variables
│           ├── 01-env-darwin.fish        # macOS-specific (Homebrew)
│           ├── 01-env-linux.fish         # Linux-specific paths
│           ├── 10-interactive.fish       # atuin, direnv, starship
│           ├── 99-secrets.fish           # Actual secrets (gitignored)
│           └── 99-secrets.fish.template  # Template
├── zsh/
│   ├── dot-zshrc            # Main zshrc (sources .zshrc.d/)
│   └── zshrc.d/
│       └── [similar structure to bash]
├── nushell/
│   └── dot-config/nushell/
│       ├── config.nu        # Main config
│       ├── env.nu           # Env loader (sources env.d/)
│       └── env.d/
│           └── [similar structure, Nushell syntax]
├── tmux/
│   └── dot-config/tmux/
│       ├── tmux.conf        # Main config
│       └── os/
│           ├── darwin.conf  # macOS-specific (pbcopy, ifconfig)
│           └── linux.conf   # Linux-specific (wl-copy, hostname -I)
└── git/
    ├── dot-gitconfig        # Main git config
    └── dot-config/git/hooks/
        ├── commit-msg       # Commit message validation
        └── pre-commit       # Pre-commit checks
```

## Configuration Modules

### Numbering System

Files are loaded in numerical order:

- **00-**: Core environment variables (common to all OS)
- **01-**: OS-specific environment variables (darwin/linux)
- **10-**: Interactive shell tools (atuin, starship, direnv)
- **99-**: Secrets (gitignored, loaded last)

### Shell-Specific Loading

- **Fish**: Automatically sources all files in `~/.config/fish/conf.d/`
- **Bash**: Main `.bashrc` manually sources `~/.bashrc.d/*.bash`
- **Zsh**: Main `.zshrc` manually sources `~/.zshrc.d/*.zsh`
- **Nushell**: `env.nu` sources `~/.config/nushell/env.d/*.nu`

## OS-Specific Differences

### macOS (Darwin)

- **Package manager**: Homebrew (`/opt/homebrew`)
- **Clipboard**: `pbcopy`
- **IP detection**: `ifconfig | grep 'inet '`
- **Default paths**: Homebrew bin/sbin added to PATH

### Linux

- **Package manager**: apt
- **Clipboard**: `wl-copy` (Wayland)
- **IP detection**: `hostname -I`
- **Default paths**: Standard Linux FHS paths

## tmux Configuration

The tmux configuration automatically detects the OS and loads appropriate settings:

- **Status bar**: Shows session name, IP address (with SSH detection), hostname, date, and time
- **SSH detection**: Status bar turns red when connected via SSH
- **Clipboard**: OS-specific clipboard integration (pbcopy/wl-copy)
- **Theme**: Tokyo Night with custom tweaks

## Available Make Targets

```bash
make install    # Full installation (OS-detected)
make link       # Symlink dotfiles only
make unlink     # Remove all symlinks
make clean      # Remove temporary files
make help       # Show available targets
```

## Git Hooks

Included git hooks enforce:

- **commit-msg**: Conventional commit format validation
- **pre-commit**: Blocks merge commits, AI signatures, and multi-scope commits

## Secrets Management

**Important**: Never commit actual secrets to the repository!

The `.gitignore` file excludes:
- `**/99-secrets.fish`
- `**/99-secrets.bash`
- `**/99-secrets.zsh`
- `**/99-secrets.nu`
- `claude/dot-claude.json`

Always use the template files as a reference and copy them to the actual secret files.

## Troubleshooting

### Symlinks not created

Ensure GNU Stow is installed:
```bash
# macOS
brew install stow

# Linux
sudo apt-get install stow
```

### Shell not loading configs

Restart your shell:
```bash
exec fish  # or bash/zsh
```

Or source manually:
```bash
source ~/.bashrc  # Bash
source ~/.zshrc   # Zsh
```

### Missing secrets

Copy the template and edit with your credentials:
```bash
cp fish/dot-config/fish/conf.d/99-secrets.fish.template ~/.config/fish/conf.d/99-secrets.fish
$EDITOR ~/.config/fish/conf.d/99-secrets.fish
```

## Contributing

This is a personal dotfiles repository. Feel free to fork and adapt to your needs!

## License

MIT
