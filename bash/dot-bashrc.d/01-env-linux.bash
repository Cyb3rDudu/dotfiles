# Linux-specific environment variables
# Only loaded if running on Linux

if [[ "$(uname)" == "Linux" ]]; then
    # Add common Linux paths
    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH"

    # Kubernetes configs (Linux-specific paths if different)
    export KUBECONFIG="$HOME/.kube/config"
fi
