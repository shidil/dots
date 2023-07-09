# Search and replace text in all files of pwd
# Usage: replace <search term> <replacement>
# Example: replace boring awesome
function replace
  rg -l $argv[1] | xargs sd $argv[1] $argv[2]
end
