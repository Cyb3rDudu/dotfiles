# AGENTS.md - Dotfiles Repository

## Component Overview

**dotfiles** is a unified, multi-shell configuration repository managing development
environments across macOS and Linux systems. This repository provides consistent
shell configurations, AI coding tool setups, and development tooling across
multiple machines using GNU Stow for symlink management.

### Architecture Role

This component serves as the **foundational environment layer** for development
workflows, providing:

1. **Multi-Shell Support**: Unified configurations for bash, zsh, fish, and nushell
2. **AI Tool Integration**: Configurations for Claude Code, OpenCode, and Codex
3. **Development Tools**: Git hooks, tmux, starship prompt, and more
4. **OS-Aware Configuration**: Single repository with OS-specific adaptations

### Repository Structure

```txt
dotfiles/
├── bash/                     # Bash shell configuration
│   ├── dot-bashrc           # Main bashrc with modular sourcing
│   ├── dot-bash_profile     # Login shell configuration
│   └── dot-bashrc.d/        # Modular configuration files
│       ├── 00-xdg.bash      # XDG Base Directory setup
│       ├── 01-path.bash     # PATH management
│       ├── 10-interactive.bash  # Interactive shell tools
│       ├── 20-aliases.bash  # Common aliases
│       └── 99-secrets.bash.template  # Credentials template
├── fish/                     # Fish shell configuration
│   └── dot-config/fish/
│       ├── config.fish      # Main fish config
│       ├── conf.d/          # Auto-loaded configurations
│       ├── functions/       # Fish functions
│       └── completions/     # Command completions
├── zsh/                      # Zsh shell configuration
│   ├── dot-zshrc            # Main zshrc
│   └── dot-zshrc.d/         # Modular configuration files
├── nushell/                  # Nushell configuration
│   └── dot-config/nushell/
│       ├── config.nu        # Main nushell config
│       └── env.nu           # Environment setup
├── git/                      # Git global configuration
│   ├── dot-gitconfig        # Global git config
│   ├── dot-config/git/
│   │   ├── hooks/           # Commit hooks (conventional commits)
│   │   └── ignore           # Global gitignore patterns
├── tmux/                     # Tmux terminal multiplexer
│   └── dot-config/tmux/
│       └── tmux.conf        # Tmux configuration
├── claude/                   # Claude Code AI assistant
│   ├── README.md            # Claude-specific documentation
│   └── dot-claude/
│       ├── agents/          # Custom agent definitions
│       └── mcp.json         # MCP server configuration
├── opencode/                 # OpenCode AI coding tool
│   └── dot-config/opencode/
│       ├── agent/           # Agent definitions
│       ├── prompts/         # Custom prompts
│       └── opencode.jsonc   # Main configuration
├── codex/                    # Codex AI coding tool
│   ├── README.md            # Codex-specific documentation
│   └── dot-codex/
│       └── config.toml.template  # Configuration template
├── claude-code-router/       # Dynamic model routing
│   ├── README.md            # Router documentation
│   └── dot-claude-code-router/
│       └── config.json.template  # Configuration template
├── launchagents/             # macOS LaunchAgents
│   └── Library/LaunchAgents/
│       └── environment.plist  # XDG environment variables
├── Makefile                  # Main dispatcher (OS detection)
├── Makefile.darwin           # macOS-specific targets
└── Makefile.linux            # Linux-specific targets
```

## Technology Stack

### Shell Environments

- **Bash**: Default shell with modular .bashrc.d configuration
- **Zsh**: Alternative shell with similar modular structure
- **Fish**: User-friendly shell with fisher plugin manager
- **Nushell**: Modern structured data shell

### Development Tools

- **GNU Stow**: Symlink farm manager for dotfiles deployment
- **Starship**: Cross-shell customizable prompt
- **Tmux**: Terminal multiplexer with custom status bar
- **Direnv**: Directory-based environment variable management
- **Atuin**: Shell history sync and search

### AI Coding Tools

- **Claude Code**: Anthropic's AI coding assistant
- **OpenCode**: Multi-model AI coding platform
- **Codex**: OpenAI's code generation tool
- **Claude Code Router**: Dynamic model routing based on context

## Development Commands

### Installation

```sh
# Clone repository
git clone https://github.com/Cyb3rDudu/dotfiles.git ~/Documents/Code/dotfiles
cd ~/Documents/Code/dotfiles

# Install everything (stow + secrets setup)
make install

# Or just create symlinks
make link

# Remove symlinks
make unlink

# Clean temporary files
make clean
```

### Post-Installation Setup

```sh
# 1. Edit shell secrets with your credentials
vim ~/.config/fish/conf.d/99-secrets.fish
vim ~/.bashrc.d/99-secrets.bash
vim ~/.zshrc.d/99-secrets.zsh

# 2. Edit AI tool configs (template-based only)
vim ~/.codex/config.toml
vim ~/.claude-code-router/config.json

# 3. Restart your terminal
# (logout and login for full XDG environment on macOS)
```

### AI Tool Configuration

The repository supports two credential management strategies:

#### Environment Variable Substitution (OpenCode, Claude MCP)
```jsonc
{
  "environment": {
    "GITHUB_TOKEN": "${GITHUB_PERSONAL_ACCESS_TOKEN}"
  }
}
```
- Configs tracked safely in git
- Reads from shell `99-secrets.*` files at runtime
- No template needed - config is source of truth

#### Template Pattern (Codex, Claude Code Router)
```toml
# config.toml.template (tracked in git)
env = { "GITHUB_TOKEN" = "REPLACE_WITH_YOUR_TOKEN" }

# config.toml (gitignored, created by make install)
env = { "GITHUB_TOKEN" = "ghp_actual_token_here" }
```
- Template tracked in git with placeholders
- Actual config gitignored with real secrets
- User edits actual config manually

### Commit Rules (Conventional Commits)

We use **Conventional Commits** for clear history and automated changelog generation:

```txt
<type>(<scope>): <short summary>

<body>

<footer>
```

#### Allowed Types

- **feat**: New feature
- **fix**: Bug fix
- **docs**: Documentation only
- **style**: Formatting, no logic change
- **refactor**: Code reshape, no behavior change
- **perf**: Performance improvement
- **test**: Add/modify tests
- **build**: Build system, dependencies
- **ci**: CI/CD, pipelines
- **chore**: Maintenance tasks
- **revert**: Revert a previous commit

#### Scope Discovery

```sh
# See most common scopes used
git log --format=%s \
| grep -E '^[a-z]+\(.*\):' \
| sed -nE 's/^[a-z]+\(([^)]+)\):.*/\1/p' \
| sort | uniq -c | sort -nr | head -20
```

Common scopes: `makefile`, `shells`, `fish`, `git`, `claude`, `opencode`, `mcp`, `dotfiles`

#### Examples

- `feat(claude): add fiber engineer specialized agent`
- `fix(shells): load starship before direnv to fix prompt`
- `chore(gitignore): exclude nushell history file`
- `docs(readme): update installation instructions`

#### Git Hooks

Pre-commit hooks automatically validate:
- Conventional commit format
- Flat scope requirement (no nested scopes like `backend/api`)
- No AI assistant signatures (blocks "Generated with Claude" etc.)
- Golang formatting (gofmt, golangci-lint)

### Tools

Use the following MCP servers when working with this repository:

## GitHub Integration

Comprehensive GitHub repository management via MCP:

1. Search code, issues, and pull requests
2. Manage workflow runs and CI/CD pipelines
3. Create and manage issues, PRs, and reviews
4. Handle notifications and repository operations

**Available via**: `mcp__github__*` tools

## Memory Integration

Store and recall important information across sessions:

1. Store architectural decisions and solutions
2. Remember bug fixes and workarounds
3. Track configuration changes
4. Document API changes and patterns

**Available via**: `mcp__memory__*` tools

Commands:
- Store information with tags
- Recall by semantic search or time range
- Search by tags
- Delete outdated entries

## Code Index Integration

Fast code search and analysis:

1. Advanced code pattern matching (ripgrep/ugrep)
2. File navigation by glob patterns
3. Code summarization and metrics
4. Real-time file system monitoring

**Available via**: `mcp__code-index__*` tools

**Important**: Set project path to specific subdirectories to reduce context:
```
mcp__code-index__set_project_path("fish/")
mcp__code-index__search_code_advanced("starship")
```

## Kubernetes Integration

Complete Kubernetes cluster management (if configured):

1. Pod lifecycle management
2. Resource operations (CRUD)
3. Helm chart deployment
4. Namespace and configuration management

**Available via**: `mcp__kubernetes__*` tools

**Tip**: For logs, use kubectl directly via Bash to limit output:
```sh
kubectl logs pod-name --tail=50 -n namespace
```

## Obsidian Integration

Knowledge management and note-taking:

1. File and vault operations
2. Complex JsonLogic queries
3. Periodic notes (daily, weekly, monthly)
4. Content patching and structured data

**Available via**: `mcp__mcp-obsidian__*` tools

## Key Files & Configurations

### Shell Configurations

- **Modular Structure**: All shells use numbered files in `.d/` directories
  - `00-xdg.*`: XDG Base Directory variables
  - `01-path.*`: PATH management
  - `10-interactive.*`: Interactive tools (starship, direnv, atuin)
  - `20-aliases.*`: Common aliases
  - `99-secrets.*`: Credentials (gitignored)

- **Cross-Shell Consistency**: Same aliases and tools across bash/zsh/fish/nushell

### Git Configuration

- **Hooks**: Pre-commit validation for conventional commits
- **Editor**: Vim as default (git commit uses vim)
- **Global Ignore**: Common patterns (.DS_Store, *.swp, node_modules, etc.)

### AI Tool Configurations

- **Claude**: `~/.claude/mcp.json` - MCP servers, `~/.claude/agents/` - Custom agents
- **OpenCode**: `~/.config/opencode/opencode.jsonc` - All configuration
- **Codex**: `~/.codex/config.toml` - User config (from template)
- **Router**: `~/.claude-code-router/config.json` - Model routing rules

### macOS-Specific

- **LaunchAgent**: `~/Library/LaunchAgents/environment.plist` - XDG variables for GUI apps
- **Homebrew**: Package management via `/opt/homebrew`

## Security Patterns

### Credential Management

- **Shell Secrets**: Plain text in `99-secrets.*` files (gitignored)
- **Environment Variables**: Loaded at shell startup, available to all tools
- **Template Files**: `.template` suffix for tracked files with placeholders
- **Git Exclusions**: All actual configs with secrets are gitignored

### Secret Files Never Committed

- `99-secrets.fish`, `99-secrets.bash`, `99-secrets.zsh`, `99-secrets.nu`
- `codex/dot-codex/config.toml`
- `claude-code-router/dot-claude-code-router/config.json`
- `claude/dot-claude.json` (runtime state)

## Common Tasks

### Adding a New Shell Configuration

1. Create file in appropriate `.d/` directory:
   ```sh
   vim bash/dot-bashrc.d/30-custom.bash
   ```

2. Use numbered prefix for load order:
   - `00-09`: Environment setup
   - `10-19`: Interactive tools
   - `20-29`: Aliases and functions
   - `30-89`: Custom configurations
   - `90-98`: Overrides
   - `99`: Secrets (always last)

3. Test in current shell, then commit:
   ```sh
   source ~/.bashrc
   git add bash/dot-bashrc.d/30-custom.bash
   git commit -m "feat(bash): add custom configuration"
   ```

### Adding a New AI Agent

#### For Claude Code:
```sh
vim claude/dot-claude/agents/my-agent.md
git add claude/dot-claude/agents/my-agent.md
git commit -m "feat(claude): add my-agent specialized agent"
```

#### For OpenCode:
```sh
vim opencode/dot-config/opencode/agent/my-agent.md
# Update opencode.jsonc to reference the agent
git add opencode/dot-config/opencode/agent/my-agent.md
git commit -m "feat(opencode): add my-agent"
```

### Updating MCP Server Configuration

```sh
# Edit configuration
vim claude/dot-claude/mcp.json  # or
vim opencode/dot-config/opencode/opencode.jsonc

# Add credentials to secrets file
vim ~/.config/fish/conf.d/99-secrets.fish
# set -gx NEW_SERVICE_TOKEN "your-token"

# Test and commit
git add claude/dot-claude/mcp.json
git commit -m "feat(mcp): add new-service integration"
```

### Synchronizing Across Machines

```sh
# On current machine
git add .
git commit -m "chore(config): update configurations"
git push

# On new machine
cd ~/Documents/Code/dotfiles
git pull
make link  # If symlinks broken
source ~/.bashrc  # Or restart terminal
```

## Integration Points

### Upstream Dependencies

- **GNU Stow**: Required for symlink management
- **Shell Environments**: bash, zsh, fish, nushell (optional)
- **Git**: For version control and hooks
- **Homebrew** (macOS) or package manager (Linux): For tool installation

### Downstream Consumers

- **Terminal Emulators**: iTerm2, Alacritty, kitty, etc.
- **AI Coding Tools**: Claude Code, OpenCode, Codex
- **Development Environments**: VSCode, Vim, etc.
- **CI/CD Pipelines**: Can reference git hooks for validation

## Troubleshooting

### Symlinks Not Created

```sh
# Check if stow is installed
which stow

# Manually run stow with verbose output
stow --dotfiles -v -t ~ bash

# Check for conflicts
stow --dotfiles -n -v -t ~ bash  # Dry run
```

### Environment Variables Not Loading

```sh
# Verify secrets file exists and is sourced
ls -la ~/.config/fish/conf.d/99-secrets.fish

# Check shell configuration loads it
grep -r "99-secrets" ~/.bashrc ~/.bashrc.d/

# Restart terminal completely (not just new tab)
```

### AI Tool Can't Find Credentials

```sh
# Verify environment variables are set
env | grep GITHUB_PERSONAL_ACCESS_TOKEN

# Check config uses correct variable name
cat ~/.claude/mcp.json | grep GITHUB

# Ensure secrets file has no syntax errors
source ~/.config/fish/conf.d/99-secrets.fish  # Should have no output
```

### Git Hooks Rejecting Commits

```sh
# Check commit message format
git log -1 --format=%s

# Manually run commit-msg hook
.git/hooks/commit-msg .git/COMMIT_EDITMSG

# Temporarily disable hooks (not recommended)
git commit --no-verify -m "message"
```

## Reference

- [GNU Stow Manual](https://www.gnu.org/software/stow/manual/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [Starship Documentation](https://starship.rs/)
