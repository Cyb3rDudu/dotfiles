# Codex Configuration

This directory contains configuration for OpenAI Codex.

## Setup

1. **Install Codex** (if not already installed)

2. **Automatic config generation:**
   - When you run `make install`, the config.toml is automatically generated from the template
   - Credentials are sourced from `~/.bashrc.d/99-secrets.bash`
   - No manual editing required!

3. **Manual regeneration** (if needed):
   ```bash
   bash codex/generate-config.sh
   ```

4. **Required credentials in your shell secrets:**
   - `GITHUB_TOKEN` / `GITHUB_PERSONAL_ACCESS_TOKEN`: GitHub PAT with `repo` and `project` scopes
   - `OBSIDIAN_API_KEY`: From Obsidian Local REST API plugin
   - `ALM_URL`, `ALM_USERNAME`, `ALM_PASSWORD`: ALM device credentials
   - `SONARQUBE_TOKEN`, `SONARQUBE_ORG`: SonarQube credentials

5. **Stow will manage:**
   - `config.toml.template` - Template with placeholder credentials
   - `version.json` - Version info
   - `internal_storage.json` - Non-sensitive storage

6. **Git-ignored files** (user-specific, contain secrets):
   - `config.toml` - Auto-generated with your credentials
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
