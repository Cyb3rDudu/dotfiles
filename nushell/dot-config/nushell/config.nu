# Main Nushell configuration
# Interactive shell tools and UI configuration

# Disable welcome banner
$env.config = ($env.config | upsert show_banner false)

# Starship - cross-shell prompt
# Automatically loaded from $nu.data-dir/vendor/autoload/starship.nu
# After XDG_DATA_HOME is set (via env.d/01-env-darwin.nu), this will be:
# ~/.local/share/nushell/vendor/autoload/starship.nu (stow managed)

# Atuin - shell history sync
# init.nu is stow-managed at ~/.local/share/atuin/init.nu (generated with ATUIN_NOBIND=true)
if (which atuin | is-not-empty) {
    source ~/.local/share/atuin/init.nu

    # Add Ctrl+R keybinding for atuin search
    $env.config = ($env.config | upsert keybindings (
        $env.config.keybindings
        | append {
            name: atuin
            modifier: control
            keycode: char_r
            mode: [emacs, vi_normal, vi_insert]
            event: { send: executehostcommand, cmd: (_atuin_search_cmd) }
        }
    ))
}

# Direnv - directory-based environment variables
# Note: direnv doesn't officially support Nushell yet (as of direnv 2.37.1)
# Use Fish/Bash/Zsh for direnv functionality
# For Nushell direnv support, see: https://github.com/direnv/direnv/issues/480

# Additional configurations can be added here
