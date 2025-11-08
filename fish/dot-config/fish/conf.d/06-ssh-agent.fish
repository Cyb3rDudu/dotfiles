# SSH Agent configuration
# macOS: Uses native Keychain integration (via ~/.ssh/config UseKeychain)
# Linux: Manages ssh-agent automatically

if status is-interactive
    # On macOS, ssh-agent is managed by the system via UseKeychain
    # On Linux, we need to start it ourselves
    if test (uname) = "Linux"
        set -l SSH_ENV_FILE "$HOME/.ssh/agent.env"

        # Function to start ssh-agent
        function __start_ssh_agent
            ssh-agent -c | sed 's/^echo/#echo/' >$SSH_ENV_FILE
            chmod 600 $SSH_ENV_FILE
            source $SSH_ENV_FILE >/dev/null
        end

        # Check if agent file exists and source it
        if test -f $SSH_ENV_FILE
            source $SSH_ENV_FILE >/dev/null
        end

        # Test if agent is running
        if not ssh-add -l >/dev/null 2>&1
            __start_ssh_agent
        end

        # Add SSH key if not already added
        if not ssh-add -l 2>/dev/null | grep -q id_ed25519
            if test -f ~/.ssh/id_ed25519
                ssh-add ~/.ssh/id_ed25519 2>/dev/null
            end
        end
    end
end
