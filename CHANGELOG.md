# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project uses [Conventional Commits](https://conventionalcommits.org).

## [Unreleased]

### 2025-11-07

#### Added
- **Makefile**: Complete automation for AI tool configs (Claude, OpenCode, Codex, Claude Code Router)
- **Claude Code Router**: Dynamic model routing configuration with multi-provider support (OpenRouter, DeepSeek, Ollama)
- **Claude**: Fiber Engineer specialized agent for OTDR analysis and fiber link monitoring
- **OpenCode**: Fiber agent and memory-context prompt for session management
- **MCP**: Consolidated MCP server configurations across all AI coding tools
- **Shells**: Common aliases across bash, zsh, fish, and nushell
- **macOS**: XDG Base Directory support with LaunchAgent integration
- **Nushell**: Full shell integration with XDG support and starship
- **Tmux**: Hostname, IP address, and SSH session indicators in status bar
- **Git**: Enhanced commit hooks with conventional commits validation

#### Changed
- **Dotfiles**: Unified osx/linux branches into single modular multi-shell configuration
- **Dotfiles**: Added stow --dotfiles flag support, renamed _config to dot-config
- **Shells**: Starship now loads before direnv to prevent prompt conflicts
- **Nushell**: Updated to use vendor autoload system for starship
- **Git**: Set vim as default editor, improved commit message validation

#### Fixed
- **Claude**: Runtime state file (dot-claude.json) now gitignored
- **Git**: Restrict merge detection to subject line only
- **Shells**: Bash login shell now properly sources .bashrc

### 2025-09-14

#### Fixed
- **Git**: Prevent false positives in merge commit detection

### 2025-09-10

#### Changed
- **Commits**: Require flat scopes and block AI assistant signatures
- **Claude**: Remove deprecated files, add new agent configurations
- **Git**: Tighten hook enforcement, add commitlint validation

### 2025-09-03

#### Changed
- **OpenCode**: Rename fullstack-go-ts agent to coder, update model configurations
- **Fish**: Extend PATH with LM Studio and net-snmp binaries

### 2025-09-02

#### Added
- **Claude**: Agent definition prompts for Claude Code
- **OpenCode**: Per-agent tool policies and new fullstack agent

### 2025-09-01

#### Added
- **OpenCode**: DevOps Engineer Agent for CI/CD and IaC workflows
- **OpenCode**: Documentation Writer agent
- **OpenCode**: Extended fleet of specialized agents

#### Changed
- **OpenCode**: Standardize agent documentation format

### 2025-08-31

#### Added
- **OpenCode**: Agent definitions and orchestrator configuration

### 2025-07-22

#### Fixed
- **Hooks**: Run golangci-lint on entire Go module instead of individual files

#### Changed
- **Environment**: Switch from MacPorts to Homebrew for fish shell and zlib

### 2025-07-02

#### Changed
- **Fish**: Include theia-dev kubeconfig in KUBECONFIG

### 2025-05-19

#### Added
- **Git**: Pre-commit hook for gofmt and golangci-lint
- **Makefile**: Stow-based dotfiles management
- **Pre-commit**: Configuration for go, python, and standard hooks
- **Starship**: Complete overhaul with new sections, palette, and prompt modules
- **Git**: Global hooks, config, and ignore patterns

#### Changed
- **Fish**: Update local-llama model to gemma3:12b
- **Prompt**: Add git/hg branch and dirty state indicators

### 2025-04-01

#### Added
- **Fish**: Go bin directory to user paths

#### Changed
- **Fish**: Update initialization and search highlight color
- **Fish**: Update KUBECONFIG path

### 2025-03-11

#### Added
- **Fish**: Alias for vscodium
- **Fish**: b2 command support
- **Tmux**: Make tabs movable with Ctrl+Shift+Arrow

### 2025-02-21

#### Added
- **Fish**: fisher-ai plugin for AI-powered command line
- **Fish**: rustup integration
- **Fish**: kubeconfig support

#### Changed
- **Atuin**: Update configuration

#### Fixed
- **Fish**: AI config corrections

### 2024-09-25

#### Added
- **Fish**: kubectl alias 'c' for macOS

### 2024-09-24

#### Added
- **Linux**: direnv trigger integration

### 2024-08-30

#### Removed
- **macOS**: vscodium shortcut from fish config

### 2024-08-28

#### Added
- **Linux**: fisher and gvm integration

### 2024-08-26

#### Fixed
- **macOS**: Copy behavior corrections

### 2024-08-16

#### Added
- **macOS**: fisher for fish plugin management
- **Linux**: arkship setup in UTM

### 2024-08-15

#### Added
- **Branch**: Separate osx branch created

### 2024-08-14

#### Added
- **Testing**: decman test implementation

### 2024-08-13

#### Added
- **NixOS**: home.nix and configuration.nix for pentest host

### 2024-08-10

#### Added
- **Linux**: Initial stow deployment configuration

## Legend

- **Added**: New features
- **Changed**: Changes in existing functionality
- **Deprecated**: Soon-to-be removed features
- **Removed**: Removed features
- **Fixed**: Bug fixes
- **Security**: Security improvements
