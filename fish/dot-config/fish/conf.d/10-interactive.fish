# Interactive shell configuration
# Tools and UI that only run in interactive sessions

if status is-interactive
    # Atuin - shell history sync
    if type -q atuin
        set -gx ATUIN_NOBIND "true"
        atuin init fish | source
        bind \cr _atuin_bind_up
    end

    # Direnv - directory-based environment variables (Darwin only for now)
    if test (uname) = Darwin; and type -q direnv
        direnv hook fish | source
    end

    # Starship - cross-shell prompt
    if type -q starship
        starship init fish | source
    end

    # TMUX auto-attach (commented out - enable if desired)
    # if not set -q TMUX
    #     tmux attach -t base || tmux new -s base
    # end
end
