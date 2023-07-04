function zn
    set dir $(ls -D | fzf)
    zellij options --session-name $dir --default-cwd $dir
end

