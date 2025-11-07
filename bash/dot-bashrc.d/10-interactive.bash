# Interactive shell configuration
# Tools and UI that only run in interactive sessions

# Starship - cross-shell prompt (must be loaded BEFORE direnv to avoid PROMPT_COMMAND conflict)
if command -v starship &> /dev/null; then
    eval "$(starship init bash)"
fi

# Direnv - directory-based environment variables (Darwin only for now)
if [[ "$(uname)" == "Darwin" ]] && command -v direnv &> /dev/null; then
    eval "$(direnv hook bash)"
fi

# Atuin - shell history sync
if command -v atuin &> /dev/null; then
    export ATUIN_NOBIND="true"
    eval "$(atuin init bash)"
    bind -x '"\C-r": __atuin_history'
fi

# TMUX auto-attach (commented out - enable if desired)
# if [[ -z "$TMUX" ]]; then
#     tmux attach -t base || tmux new -s base
# fi
