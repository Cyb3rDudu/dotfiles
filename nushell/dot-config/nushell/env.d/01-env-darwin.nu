# macOS-specific environment variables
# Only loaded if running on Darwin (macOS)

if (sys | get host.name) == "Darwin" {
    # Homebrew configuration
    $env.HOMEBREW_PREFIX = "/opt/homebrew"
    $env.PATH = ($env.PATH | prepend $"($env.HOMEBREW_PREFIX)/bin" | prepend $"($env.HOMEBREW_PREFIX)/sbin")

    # Dynamic library path for Homebrew zlib
    $env.DYLD_LIBRARY_PATH = $"($env.HOMEBREW_PREFIX)/opt/zlib/lib"

    # Kubernetes configs (macOS-specific paths)
    $env.KUBECONFIG = $"($env.HOME)/.kube/config:($env.HOME)/.kube/prod_eu_01_config:($env.HOME)/.kube/theia-dev"
}
