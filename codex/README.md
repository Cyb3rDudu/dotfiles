# Codex Configuration

This directory contains configuration for OpenAI Codex.

## Setup

1. **Install Codex** (if not already installed)

2. **Copy template to create your config:**
   ```bash
   cd ~/.codex
   cp config.toml.template config.toml
   ```

3. **Add your credentials to config.toml:**
   - `GITHUB_TOKEN`: Create at https://github.com/settings/tokens with `repo` and `project` scopes
   - `OBSIDIAN_API_KEY`: Get from Obsidian Local REST API plugin settings
   - `ALM_URL`, `ALM_USERNAME`, `ALM_PASSWORD`: Your ALM device credentials

4. **Stow will manage:**
   - `config.toml.template` - Template with placeholder credentials
   - `version.json` - Version info
   - `internal_storage.json` - Non-sensitive storage

5. **Git-ignored files** (user-specific, contain secrets):
   - `config.toml` - Actual config with your credentials
   - `auth.json` - OAuth tokens
   - `history.jsonl` - Command history
   - `sessions/` - Session data
   - `log/` - Log files

## File Structure

```
~/.codex/
├── config.toml          (gitignored - copy from template)
├── config.toml.template (tracked - stow managed)
├── auth.json            (gitignored - auto-generated)
├── history.jsonl        (gitignored - auto-generated)
├── version.json         (tracked - stow managed)
├── internal_storage.json (tracked - stow managed)
├── sessions/            (gitignored - auto-generated)
└── log/                 (gitignored - auto-generated)
```

## MCP Servers

Configured MCP servers (credentials required):
- **code-index** - Code indexing (no credentials)
- **memory** - Memory service (no credentials)
- **kubernetes** - Kubernetes management (kubeconfig path)
- **projects** - GitHub Projects (requires GITHUB_TOKEN)
- **github** - GitHub API (requires GITHUB_PERSONAL_ACCESS_TOKEN)
- **obsidian** - Obsidian integration (requires OBSIDIAN_API_KEY)
- **browsermcp** - Browser automation (no credentials)
- **alm** - Fiber optics ALM device (requires ALM credentials)
