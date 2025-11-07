# macOS-specific environment variables
# Only loaded if running on Darwin (macOS)

if [[ "$(uname)" == "Darwin" ]]; then
    # XDG Base Directory - force macOS apps to use ~/.config instead of ~/Library/Application Support
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_DATA_HOME="$HOME/.local/share"
    export XDG_CACHE_HOME="$HOME/.cache"

    # Homebrew configuration
    export HOMEBREW_PREFIX=/opt/homebrew
    export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"

    # Dynamic library path for Homebrew zlib
    export DYLD_LIBRARY_PATH="$HOMEBREW_PREFIX/opt/zlib/lib:$DYLD_LIBRARY_PATH"

    # Kubernetes configs (macOS-specific paths)
    export KUBECONFIG="$HOME/.kube/config:$HOME/.kube/prod_eu_01_config:$HOME/.kube/theia-dev"
fi
