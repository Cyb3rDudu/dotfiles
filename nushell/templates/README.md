# Nushell Templates

This directory contains template files for Nushell that need to be manually copied to specific locations.

## Files

### atuin-init.nu

**Purpose**: Atuin integration for Nushell with custom keybindings disabled

**Copy to**: `~/.local/share/atuin/init.nu`

```bash
cp nushell/templates/atuin-init.nu ~/.local/share/atuin/init.nu
```

**Why not stow-managed?**

The `~/.local/share/atuin/` directory contains user-specific data:
- History database (history.db)
- Sync state and credentials
- Local cache files

We cannot symlink the entire directory or individual files within it without causing stow conflicts with the existing user data.

**Regenerating**:

If you need to regenerate this template (e.g., after updating Atuin):

```bash
ATUIN_NOBIND=true atuin init nu > nushell/templates/atuin-init.nu
```

The `ATUIN_NOBIND=true` environment variable tells Atuin not to set up its own keybindings, as we configure Ctrl+R manually in `config.nu`.

## Adding New Templates

If you need to add more templates for Nushell tools:

1. Generate the file and save it in this directory
2. Document it in this README
3. Add instructions to the main README.md
4. Do NOT add it to `dot-local/` or `dot-config/` if it belongs in a directory with user data
