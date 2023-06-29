function zs
  set session $(zellij list-sessions | fzf)
  zellij attach $session
end

