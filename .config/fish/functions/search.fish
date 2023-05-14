function search
  ag -l $argv[1] | fzf --preview 'bat --style numbers,changes --color=always {} | head -500'
end

function search_run
  search $argv[1] | xargs $argv[2]
end

function search_vi
  search_run $argv[1] nvim
end

function find_run
  fd $argv[1] | fzf | xargs $argv[2]
end

function find_vi
  find_run $argv[1] nvim
end

# usage
# search "term"

# usage with open result in nvim
# search "term" | xargs nvim
# search_vi "term"

function replace
  ag -0 -l --nocolor $argv[1] | xargs -0 perl -pi.bak -e "s/$argv[1]/$argv[2]/g"
end
