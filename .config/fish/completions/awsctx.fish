set -l profiles $(aws configure list-profiles)
complete -c awsctx -f -a "$profiles"
