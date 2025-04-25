if status is-interactive
    # Commands to run in interactive sessions can go here
end

set VOLTA_HOME "$HOME/.volta"
set PATH "$VOLTA_HOME/bin:$PATH"
#set ANDROID_SDK_ROOT "$HOME//Library/Android/sdk"

set XDG_CONFIG_HOME "$HOME/.config/"

# https://sidneyliebrand.medium.com/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861
set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'

# https://github.com/catppuccin/fzf#usage
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

set -gx EDITOR "nvim"
set BAT_THEME "Catppuccin-mocha"

# Colors for man pages https://jedsoft.org/most/
#set -x PAGER "most"
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

# gpg pinentry
set -x GPG_TTY $(tty)

zoxide init fish | source
starship init fish | source
direnv hook fish | source

# https://github.com/eza-community/eza
alias ls "eza -w 100"
# https://github.com/sharkdp/fd
alias find "fd"
# https://github.com/BurntSushi/ripgrep
alias grep "rg"
alias ack "rg"
#
alias dir "eza --color always --tree --level=1 --icons --git --group-directories-first"
alias vi "nvim"
alias vim "nvim"
alias k "kubectl"
alias ed "find_vi"

alias cd "z"
alias less "bat"

set -x AWS_PROFILE default
set -x AWS_REGION ap-southeast-2

source ~/.config/fish/functions/search.fish
source ~/.config/fish/functions/git.fish

fish_vi_key_bindings
