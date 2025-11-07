# Linux-specific environment variables
# Only loaded if running on Linux

if ($nu.os-info.name == "linux") {
    # Add common Linux paths
    $env.PATH = ($env.PATH | prepend "/usr/local/bin" | prepend "/usr/bin" | prepend "/bin" | prepend "/usr/local/sbin" | prepend "/usr/sbin" | prepend "/sbin")

    # Kubernetes configs (Linux-specific paths if different)
    $env.KUBECONFIG = $"($env.HOME)/.kube/config"
}
