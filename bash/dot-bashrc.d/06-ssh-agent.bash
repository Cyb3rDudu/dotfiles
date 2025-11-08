# SSH Agent configuration
# macOS: Uses native Keychain integration (via ~/.ssh/config UseKeychain)
# Linux: Uses systemd user service

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/ssh-agent.socket"
fi
