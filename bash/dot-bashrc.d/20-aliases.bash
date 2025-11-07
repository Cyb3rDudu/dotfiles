# Common aliases for all shells
# Note: Fish uses functions instead (see fish/functions/)

# Modern ls replacement - lsd (LSDeluxe)
if command -v lsd &> /dev/null; then
    alias ls='lsd'
    alias ll='lsd -lah'
else
    # Fallback to traditional ls with colors
    alias ls='ls --color=auto'
    alias ll='ls -lah'
fi

# VS Code / VSCodium
if command -v codium &> /dev/null; then
    alias code='codium'
elif command -v code &> /dev/null; then
    # code already exists, no alias needed
    :
fi
