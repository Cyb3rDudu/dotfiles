# Interactive shell configuration
# Tools and UI that only run in interactive sessions

# Check if running interactively
if [[ -o interactive ]]; then
    # Atuin - shell history sync
    if (( $+commands[atuin] )); then
        export ATUIN_NOBIND="true"
        eval "$(atuin init zsh)"
        bindkey '^r' _atuin_search_widget
    fi

    # Direnv - directory-based environment variables (Darwin only for now)
    if [[ "$(uname)" == "Darwin" ]] && (( $+commands[direnv] )); then
        eval "$(direnv hook zsh)"
    fi

    # Starship - cross-shell prompt
    if (( $+commands[starship] )); then
        eval "$(starship init zsh)"
    fi

    # TMUX auto-attach (commented out - enable if desired)
    # if [[ -z "$TMUX" ]]; then
    #     tmux attach -t base || tmux new -s base
    # fi
fi
