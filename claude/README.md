# Claude Code Configuration

This directory contains configuration for Anthropic Claude Code.

## Setup

Claude Code stores its configuration in `~/.claude/` which is managed by stow.

### MCP Servers

MCP servers are configured in `mcp.json` and use environment variables for credentials.

**Setting up credentials:**

Add your MCP credentials to your shell's secrets file:
- Fish: `~/.config/fish/conf.d/99-secrets.fish`
- Bash: `~/.bashrc.d/99-secrets.bash`
- Zsh: `~/.zshrc.d/99-secrets.zsh`

Templates are provided in the dotfiles repo - copy and customize:
```bash
cp fish/dot-config/fish/conf.d/99-secrets.fish.template ~/.config/fish/conf.d/99-secrets.fish
cp bash/dot-bashrc.d/99-secrets.bash.template ~/.bashrc.d/99-secrets.bash
cp zsh/dot-zshrc.d/99-secrets.zsh.template ~/.zshrc.d/99-secrets.zsh
```

### File Structure

```
~/.claude/
├── mcp.json              (tracked - stow managed, uses env vars)
├── .claude.json          (gitignored - runtime state, contains tokens)
├── agents/               (tracked - custom agent definitions)
└── commands/             (tracked - custom slash commands)
```

### MCP Servers Configured

**No credentials needed:**
- **code-index** - Code indexing and search
- **memory** - Persistent memory service
- **browsermcp** - Browser automation
- **docfork** - Documentation search

**Credentials required (set in 99-secrets.*):**
- **github** - GitHub API (`GITHUB_PERSONAL_ACCESS_TOKEN`)
- **projects** - GitHub Projects (`GITHUB_PERSONAL_ACCESS_TOKEN`)
- **obsidian** - Obsidian notes (`OBSIDIAN_API_KEY`)
- **kubernetes** - K8s management (uses KUBECONFIG path)
- **alm** - Fiber optics monitoring (`ALM_URL`, `ALM_USERNAME`, `ALM_PASSWORD`)
- **freqtrade-mcp** - Trading bot (`FREQTRADE_API_URL`, `FREQTRADE_API_USERNAME`, `FREQTRADE_API_PASSWORD`)
- **grafana** - Grafana observability (`GRAFANA_URL`, `GRAFANA_SERVICE_ACCOUNT_TOKEN`)

### GitHub Token Setup

Create a Personal Access Token at https://github.com/settings/tokens

Required scopes:
- `repo` - Full control of private repositories
- `project` - Full control of projects (for GitHub Projects integration)

Add to your secrets file:
```fish
# Fish
set -gx GITHUB_PERSONAL_ACCESS_TOKEN "ghp_your_token_here"
```

```bash
# Bash/Zsh
export GITHUB_PERSONAL_ACCESS_TOKEN="ghp_your_token_here"
```

### Obsidian Setup

1. Install "Local REST API" plugin in Obsidian
2. Enable the plugin and note the API key
3. Add to your secrets file:

```fish
# Fish
set -gx OBSIDIAN_API_KEY "your_api_key_here"
```

```bash
# Bash/Zsh
export OBSIDIAN_API_KEY="your_api_key_here"
```

## Integration with Other Tools

This MCP configuration is shared conceptually with:
- **OpenCode** (`~/.config/opencode/opencode.jsonc`) - Uses same environment variables
- **Codex** (`~/.codex/config.toml`) - Uses same environment variables

All three tools source credentials from the same shell secrets files, ensuring consistent configuration across your development environment.
