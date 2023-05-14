function gsync
  set branch_name $(git branch --show-current)
  # assumption
  set remote origin
  git pull $remote $branch_name 
  git push $remote $branch_name
end

