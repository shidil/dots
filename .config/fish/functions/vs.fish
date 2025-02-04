function vs
  set dir ~/.local/state/nvim/sessions
  set file $(ls $dir | fzf)
  nvim -S $dir/$file
end
