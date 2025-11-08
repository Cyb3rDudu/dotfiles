# SSH Agent configuration
# macOS: Uses native Keychain integration (via ~/.ssh/config UseKeychain)
# Linux: Manages ssh-agent automatically

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    SSH_ENV_FILE="$HOME/.ssh/agent.env"

    # Function to start ssh-agent
    __start_ssh_agent() {
        ssh-agent | sed 's/^echo/#echo/' > "$SSH_ENV_FILE"
        chmod 600 "$SSH_ENV_FILE"
        . "$SSH_ENV_FILE" >/dev/null
    }

    # Check if agent file exists and source it
    if [ -f "$SSH_ENV_FILE" ]; then
        . "$SSH_ENV_FILE" >/dev/null
    fi

    # Test if agent is running
    if ! ssh-add -l >/dev/null 2>&1; then
        __start_ssh_agent
    fi

    # Add SSH key if not already added
    if ! ssh-add -l 2>/dev/null | grep -q id_ed25519; then
        if [ -f ~/.ssh/id_ed25519 ]; then
            ssh-add ~/.ssh/id_ed25519 2>/dev/null
        fi
    fi
fi
