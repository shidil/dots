if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x XDG_CONFIG_HOME "$HOME/.config/"

# https://sidneyliebrand.medium.com/how-fzf-and-ripgrep-improved-my-workflow-61c7ca212861
set -gx FZF_DEFAULT_COMMAND  'rg --files --no-ignore-vcs --hidden'

# https://github.com/catppuccin/fzf#usage
set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#6C7086,label:#CDD6F4"

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

alias dir "eza --color always --tree --level=1 --icons --git --group-directories-first"
alias vi "nvim"
alias vim "nvim"
alias k "kubectl"
alias ed "find_vi"

alias cd "z"
alias less "bat"

if type -q claude
  alias claude "GITHUB_TOKEN='' $(which claude)"
end

if type -q gh
  alias gh "GITHUB_TOKEN='' $(which gh)"
end

set -x AWS_PROFILE default
set -x AWS_REGION ap-southeast-2

if set -q XDG_RUNTIME_DIR
  set -x SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.socket
end

source ~/.config/fish/functions/search.fish
source ~/.config/fish/functions/git.fish

# Activate tirith security check
tirith init --shell fish | source

fish_vi_key_bindings

