# Main Nushell environment configuration
# Nushell automatically sources all files in ~/.config/nushell/env.d/
# Configuration is split into modular files:
#   00-env.nu           - Common environment variables
#   01-env-darwin.nu    - macOS-specific environment
#   01-env-linux.nu     - Linux-specific environment
#   99-secrets.nu       - Secrets (gitignored, copy from template)

# Source all .nu files in env.d/ directory
# Nushell 0.108+ requires explicit source statements with literal paths
# Files are loaded in order: 00-env.nu, 01-env-darwin.nu, 01-env-linux.nu, 99-secrets.nu

source ~/.config/nushell/env.d/00-env.nu
if ($nu.os-info.name == "macos") {
    source ~/.config/nushell/env.d/01-env-darwin.nu
} else if ($nu.os-info.name == "linux") {
    source ~/.config/nushell/env.d/01-env-linux.nu
}
# Source secrets if it exists (optional)
try {
    source ~/.config/nushell/env.d/99-secrets.nu
}

# Additional environment configurations can be added here or in env.d/
