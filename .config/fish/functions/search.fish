function search
	# ag -l $argv[1] | fzf --preview 'bat --style numbers,changes --color=always {} | head -500'
   rg --line-number --no-heading --color=always --smart-case "$argv" | fzf -d ':' -n 2.. --ansi --no-sort --preview-window 'down:20%:+{2}' --preview 'bat --style=numbers --color=always --highlight-line {2} {1}'
end

function search_run
  # extract file name only, cut line number and text
  search $argv[1] |  cut -f1,1 -d':' | xargs $argv[2]
end

function search_vi
  set out $(search $argv)
  set file $(echo $out | cut -f1,1 -d':')
  set line $(echo $out | cut -f1,2 -d':' | rev | cut -f1,1 -d':' | rev)
  echo $file +"normal $(echo $line)Gzz"
  nvim $file +"normal $(echo $line)Gzz"
end

function find_run
  fd -H $argv[1] | fzf | xargs $argv[2]
end

function find_vi
  find_run $argv[1] nvim
end

# usage
# search "term"

# usage with open result in nvim
# search "term" | xargs nvim
# search_vi "term"

