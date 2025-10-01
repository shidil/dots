function worktree
  set repo (git worktree list | head -n 1 | awk '{print $1}')
  set worktrees $(git worktree list | tail -n +2 | awk '{print $1}' )
  set selection (printf '%s\n' $worktrees | fzf --height 40% --layout=reverse --ansi --preview "cd {} && git -c color.status=always status | head -40" --preview-window=right:60%:wrap --prompt="WORKTREE>")
  if test -n "$selection"
    echo $selection
    cd $selection
  end
end

