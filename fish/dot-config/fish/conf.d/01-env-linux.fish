# Linux-specific environment variables
# Only loaded if running on Linux

if test (uname) = Linux
    # Add common Linux paths
    set -gx PATH /usr/local/bin /usr/bin /bin /usr/local/sbin /usr/sbin /sbin $PATH

    # Kubernetes configs (Linux-specific paths if different)
    set -gx KUBECONFIG "$HOME/.kube/config"
end
