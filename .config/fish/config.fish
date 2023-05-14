if status is-interactive
    # Commands to run in interactive sessions can go here
end

set VOLTA_HOME "$HOME/.volta"
set PATH "$VOLTA_HOME/bin:$PATH"
set PATH "/opt/homebrew/opt/openjdk@11/bin:$PATH"
set ANDROID_SDK_ROOT "$HOME//Library/Android/sdk"
set PATH $PATH:/Users/shidile/.linkerd2/bin
set PATH $PATH:/Applications/Docker.app/Contents/Resources/bin
set PATH $PATH:/Users/shidile/go/bin

set FZF_DEFAULT_COMMAND 'ag -g ""'
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"

set EDITOR "nvim"
set BAT_THEME "Catppuccin-macchiato"

alias ls "exa"
alias find "fd"
alias grep "rg"
alias ack "ag"
alias dir "br"
alias vi "nvim"
alias vim "nvim"
alias k "kubectl"

# alias cd "z"
alias less "bat"
alias k9s "XDG_CONFIG_HOME=~/.config ~/go/bin/k9s"

zoxide init fish | source
starship init fish | source
direnv hook fish | source

set -x AWS_PROFILE default
set -x AWS_REGION ap-southeast-2

source ~/.config/fish/functions/search.fish
source ~/.config/fish/functions/git.fish

fish_vi_key_bindings

set XDG_CONFIG_HOME "/Users/shidile/.config/"
