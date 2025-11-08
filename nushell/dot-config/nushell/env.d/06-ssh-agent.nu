# SSH Agent configuration
# macOS: Uses native Keychain integration (via ~/.ssh/config UseKeychain)
# Linux: Manages ssh-agent automatically

if (sys host | get name) == "Linux" {
    let ssh_env_file = $"($env.HOME)/.ssh/agent.env"

    # Check if agent file exists and source it
    if ($ssh_env_file | path exists) {
        # Parse the agent.env file and set environment variables
        open $ssh_env_file
        | lines
        | parse "setenv {key} {value};"
        | each { |it|
            load-env { ($it.key): ($it.value | str trim) }
        }
    }

    # Test if agent is running, start if not
    if (do -i { ssh-add -l } | complete | get exit_code) != 0 {
        # Start new ssh-agent
        let agent_output = (ssh-agent -c | str replace 'echo' '#echo' | save -f $ssh_env_file)

        # Source the newly created file
        open $ssh_env_file
        | lines
        | parse "setenv {key} {value};"
        | each { |it|
            load-env { ($it.key): ($it.value | str trim) }
        }
    }

    # Add SSH key if not already added
    if (do -i { ssh-add -l } | complete | get stdout | str contains 'id_ed25519') == false {
        if ($"($env.HOME)/.ssh/id_ed25519" | path exists) {
            do -i { ssh-add $"($env.HOME)/.ssh/id_ed25519" } | ignore
        }
    }
}
