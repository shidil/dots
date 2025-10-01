function prj
  set projects (ls ~/projects | xargs -n 1)
  set selection (printf '%s\n' $projects | fzf --height 40% --layout=reverse --ansi --preview "tree -d 2 ~/projects/{} | head -40" --preview-window=right:60%:wrap --prompt="PROJECT>")
  if test -n "$selection"
    echo $selection
    cd ~/projects/$selection
  end
end

