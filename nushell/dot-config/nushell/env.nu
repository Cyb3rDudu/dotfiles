# Main Nushell environment configuration
# Nushell automatically sources all files in ~/.config/nushell/env.d/
# Configuration is split into modular files:
#   00-env.nu           - Common environment variables
#   01-env-darwin.nu    - macOS-specific environment
#   01-env-linux.nu     - Linux-specific environment
#   99-secrets.nu       - Secrets (gitignored, copy from template)

# Source all .nu files in env.d/ directory
if ($env | get --ignore-errors PWD | is-not-empty) {
    let env_dir = $"($env.HOME)/.config/nushell/env.d"
    if ($env_dir | path exists) {
        ls $"($env_dir)/*.nu" | each { |file|
            source $file.name
        }
    }
}

# Additional environment configurations can be added here or in env.d/
