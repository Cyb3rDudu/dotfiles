# SSH Agent configuration
# macOS: Uses native Keychain integration (via ~/.ssh/config UseKeychain)
# Linux: Uses systemd user service

if test (uname) = "Linux"
    set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/ssh-agent.socket"
end
