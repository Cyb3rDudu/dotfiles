# Nushell Setup on macOS

## The macOS Config Path Issue

By default, Nushell on macOS uses `~/Library/Application Support/nushell/` for its configuration files instead of the XDG-compliant `~/.config/nushell/` path that Linux and other Unix systems use.

You can verify your current config path:
```bash
nu -c 'echo $nu.config-path'
# macOS default: /Users/username/Library/Application Support/nushell/config.nu
# XDG path:      /Users/username/.config/nushell/config.nu
```

## Solution: Force XDG Paths

This dotfiles repository includes XDG Base Directory variables in the macOS-specific environment configs to force standard `~/.config/` usage:

```bash
# Set in all shell configs (Fish, Bash, Zsh, Nushell)
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
```

**Important**: These environment variables must be set **before** Nushell starts. Simply adding them to Nushell's `env.nu` won't work because Nushell has already determined its config path by the time it reads that file.

## Setup Options

### Option 1: Shell Environment (Included in Dotfiles)

The dotfiles automatically set XDG variables when you launch Nushell from Fish, Bash, or Zsh. After running `make install`, just restart your terminal:

```bash
# After make install and terminal restart
nu -c 'echo $nu.config-path'
# Should now show: /Users/username/.config/nushell/config.nu
```

### Option 2: LaunchAgent (For Login Shell)

If you want to use Nushell as a login shell or launch it directly (not from another shell), you need to set XDG variables at the system level using a LaunchAgent.

Create `~/Library/LaunchAgents/environment.plist`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>my.startup.shell_agnostic.environment</string>
  <key>ProgramArguments</key>
  <array>
    <string>sh</string>
    <string>-c</string>
    <string>
      launchctl setenv XDG_CONFIG_HOME ~/.config
      launchctl setenv XDG_DATA_HOME ~/.local/share
      launchctl setenv XDG_CACHE_HOME ~/.cache
    </string>
  </array>
  <key>RunAtLoad</key>
  <true/>
</dict>
</plist>
```

Load the LaunchAgent:
```bash
launchctl load ~/Library/LaunchAgents/environment.plist
```

Then log out and log back in for it to take effect system-wide.

**To use Nushell as login shell**:
```bash
# Add Nushell to allowed shells
sudo sh -c 'echo $(which nu) >> /etc/shells'

# Set as default shell
chsh -s $(which nu)
```

## One-Time Tool Setup

After XDG paths are configured, set up Starship and Atuin:

### Starship (vendor autoload system)

```bash
nu -c 'mkdir ($nu.data-dir | path join "vendor/autoload")'
nu -c 'starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")'
```

### Atuin (shell history with Ctrl+R)

```bash
mkdir -p ~/.local/share/atuin
nu -c '$env.ATUIN_NOBIND = "true"; atuin init nu | save -f ~/.local/share/atuin/init.nu'
```

The Ctrl+R keybinding is already configured in `config.nu`.

## Verifying Everything Works

After setup, verify your environment in a new terminal:

```bash
# Check config path
nu -c 'echo $nu.config-path'
# Expected: /Users/username/.config/nushell/config.nu

# Check XDG variables
nu -c 'echo $env.XDG_CONFIG_HOME'
# Expected: /Users/username/.config

# Check that environment variables load
nu -c 'echo $env.EDITOR'
# Should show your editor (e.g., nvim, vim)

# Check Starship
nu
# Should see Starship prompt

# Check Atuin
# Press Ctrl+R in Nushell
# Should open Atuin history search
```

## Troubleshooting

### Configs still loading from ~/Library/Application Support

This means XDG variables aren't set before Nushell starts:

1. **If launching from another shell**: Restart your terminal completely (not just the shell)
2. **If using as login shell**: Set up the LaunchAgent (Option 2 above) and log out/in
3. **Verify XDG is set**: `nu -c 'echo $env.XDG_CONFIG_HOME'` should show `/Users/username/.config`

### Atuin Ctrl+R doesn't work

1. Verify Atuin init file exists: `ls ~/.local/share/atuin/init.nu`
2. Verify config loads: `nu -c 'source ~/.local/share/atuin/init.nu; _atuin_search_cmd'`
3. Check if it was created with NOBIND: `grep NOBIND ~/.local/share/atuin/init.nu`
4. Regenerate if needed:
   ```bash
   nu -c '$env.ATUIN_NOBIND = "true"; atuin init nu | save -f ~/.local/share/atuin/init.nu'
   ```

### Starship doesn't show

1. Verify vendor autoload exists: `ls ($nu.data-dir | path join "vendor/autoload/starship.nu")`
2. Regenerate if needed:
   ```bash
   nu -c 'starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")'
   ```

## Technical Background

### Why This Happens

macOS applications traditionally use `~/Library/Application Support/` for config storage, while Unix/Linux systems follow the XDG Base Directory specification using `~/.config/`. Nushell defaults to the platform-native path.

### Why XDG_CONFIG_HOME Works

Nushell respects the XDG Base Directory specification when `XDG_CONFIG_HOME` is set in the environment **before** it starts. This is why it must be set at the system level (LaunchAgent) or by the parent shell that launches Nushell.

### Alternative: Nushell Could Be Smarter

As noted in the Nushell community, the shell could be enhanced to check for `~/.config/nushell/` even without `XDG_CONFIG_HOME` set, since `~/.config` is the most common location across platforms. This would eliminate the need for explicit XDG setup on macOS.

## References

- [Nushell macOS config path discussion](https://github.com/nushell/nushell/discussions/5279)
- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [Stack Overflow: macOS LaunchAgent environment](https://stackoverflow.com/questions/135688/setting-environment-variables-on-os-x)
