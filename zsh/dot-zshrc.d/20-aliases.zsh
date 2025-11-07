# Common aliases for all shells
# Note: Fish uses functions instead (see fish/functions/)

# Modern ls replacement - lsd (LSDeluxe)
if (( $+commands[lsd] )); then
    alias ls='lsd'
    alias ll='lsd -lah'
else
    # Fallback to traditional ls with colors
    alias ls='ls --color=auto'
    alias ll='ls -lah'
fi

# VS Code / VSCodium
if (( $+commands[codium] )); then
    alias code='codium'
elif (( $+commands[code] )); then
    # code already exists, no alias needed
    :
fi
