function obsidian_sync 
    cd ~/Documents/obsidian
    git status
    git add .
    git commit -m "chore: sync"
    git push
    cd -
end
