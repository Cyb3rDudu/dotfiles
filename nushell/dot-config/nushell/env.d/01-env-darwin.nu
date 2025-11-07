# macOS-specific environment variables
# Only loaded if running on Darwin (macOS)

if ($nu.os-info.name == "macos") {
    # XDG Base Directory - force macOS apps to use ~/.config instead of ~/Library/Application Support
    $env.XDG_CONFIG_HOME = $"($env.HOME)/.config"
    $env.XDG_DATA_HOME = $"($env.HOME)/.local/share"
    $env.XDG_CACHE_HOME = $"($env.HOME)/.cache"

    # Homebrew configuration
    $env.HOMEBREW_PREFIX = "/opt/homebrew"
    $env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/bin" | prepend $"($env.HOMEBREW_PREFIX)/sbin")

    # Dynamic library path for Homebrew zlib
    $env.DYLD_LIBRARY_PATH = $"($env.HOMEBREW_PREFIX)/opt/zlib/lib"

    # Kubernetes configs (macOS-specific paths)
    $env.KUBECONFIG = $"($env.HOME)/.kube/config:($env.HOME)/.kube/prod_eu_01_config:($env.HOME)/.kube/theia-dev"
}
