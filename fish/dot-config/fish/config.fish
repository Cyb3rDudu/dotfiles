if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting 
    
    # atuin
    set -gx ATUIN_NOBIND "true"
    atuin init fish | source
    bind \cr _atuin_bind_up

    # kube
    set -gx KUBECONFIG "$HOME/.kube/config:$HOME/.kube/prod_eu_01_config:$HOME/.kube/theia-dev"

    # brew
    set -x DYLD_LIBRARY_PATH /opt/homebrew/opt/zlib/lib $DYLD_LIBRARY_PATH

    # direnv
    direnv hook fish | source

    # starship
    starship init fish | source

    # TMUX default session
    if not set -q TMUX
        tmux attach -t base || tmux new -s base
    end
end
