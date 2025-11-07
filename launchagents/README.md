# macOS LaunchAgent for XDG Environment Variables

This directory contains a macOS LaunchAgent that sets XDG Base Directory environment variables system-wide.

## What It Does

The `environment.plist` LaunchAgent sets these environment variables at login:
- `XDG_CONFIG_HOME=~/.config`
- `XDG_DATA_HOME=~/.local/share`
- `XDG_CACHE_HOME=~/.cache`

This forces macOS applications to use standard XDG paths instead of `~/Library/Application Support/`.

## When You Need This

You **need** this LaunchAgent if:
- You want to use Nushell as your **login shell** (set via `chsh`)
- You launch Nushell directly from Spotlight, Alfred, or macOS app launchers
- You want XDG variables available to **all** macOS applications, not just shells

You **don't need** this if:
- You only launch Nushell from Fish/Bash/Zsh (shell configs already set XDG vars)
- You're fine with the shell-only XDG setup

## Installation

### Via Stow (Automatic)

The `make install` or `make link` command automatically symlinks this file:
```bash
make link
```

This creates: `~/Library/LaunchAgents/environment.plist` → `dotfiles/launchagents/dot-Library/LaunchAgents/environment.plist`

### Loading the LaunchAgent

After symlinking, load the agent:
```bash
launchctl load ~/Library/LaunchAgents/environment.plist
```

### Making It Active

**Log out and log back in** for the environment variables to take effect system-wide.

You can verify it worked:
```bash
launchctl getenv XDG_CONFIG_HOME
# Should output: /Users/username/.config
```

## Using Nushell as Login Shell

Once the LaunchAgent is active, you can set Nushell as your login shell:

```bash
# Add Nushell to allowed shells
sudo sh -c 'echo $(which nu) >> /etc/shells'

# Set as default shell
chsh -s $(which nu)
```

Log out and log back in. Nushell will now start with XDG variables set and load configs from `~/.config/nushell/`.

## Unloading

To remove the LaunchAgent:
```bash
launchctl unload ~/Library/LaunchAgents/environment.plist
rm ~/Library/LaunchAgents/environment.plist
```

## Technical Details

- **Label**: `my.startup.shell_agnostic.environment`
- **Runs at**: Login (RunAtLoad)
- **Command**: Uses `launchctl setenv` to set variables in the user's login session
- **Scope**: User-specific (not system-wide)

## Alternative: Shell-Only Setup

If you don't want to use a LaunchAgent, the dotfiles already set XDG variables in all shell configs:
- `fish/dot-config/fish/conf.d/01-env-darwin.fish`
- `bash/dot-bashrc.d/01-env-darwin.bash`
- `zsh/dot-zshrc.d/01-env-darwin.zsh`
- `nushell/dot-config/nushell/env.d/01-env-darwin.nu`

This works fine when launching Nushell from another shell, but won't work for Nushell as a login shell.
