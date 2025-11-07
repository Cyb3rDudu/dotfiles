# Main Nushell configuration
# Interactive shell tools and UI configuration

# Starship - cross-shell prompt
# Automatically loaded from vendor/autoload/starship.nu
# Setup: mkdir ($nu.data-dir | path join "vendor/autoload")
#        starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# Atuin - shell history sync
if (which atuin | is-not-empty) {
    $env.ATUIN_NOBIND = "true"
    source ~/.local/share/atuin/init.nu
}

# Direnv - directory-based environment variables (Darwin only for now)
if (sys | get host.name) == "Darwin" and (which direnv | is-not-empty) {
    # Direnv integration for Nushell
    $env.config = ($env.config | upsert hooks {
        pre_prompt: [{ direnv export nu }]
    })
}

# Additional configurations can be added here
