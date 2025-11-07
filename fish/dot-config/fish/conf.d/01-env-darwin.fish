# macOS-specific environment variables
# Only loaded if running on Darwin (macOS)

if test (uname) = Darwin
    # Homebrew configuration
    set -gx HOMEBREW_PREFIX /opt/homebrew
    set -gx PATH $HOMEBREW_PREFIX/bin $HOMEBREW_PREFIX/sbin $PATH

    # Dynamic library path for Homebrew zlib
    set -gx DYLD_LIBRARY_PATH $HOMEBREW_PREFIX/opt/zlib/lib $DYLD_LIBRARY_PATH

    # Kubernetes configs (macOS-specific paths)
    set -gx KUBECONFIG "$HOME/.kube/config:$HOME/.kube/prod_eu_01_config:$HOME/.kube/theia-dev"
end
