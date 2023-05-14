# Switch aws profiles with fzf, login with sso if unauthenticated
function awsctx
  set profile $argv 
  if test -z "$argv"
    set profile $(aws configure list-profiles | fzf)
  end
  echo "Switching to AWS profile $profile"
  # TODO: support awsctx -   for switching back and forth
  # set -x PREV_AWS_PROFILE $AWS_PROFILE
  set -x AWS_PROFILE $profile
  aws sts get-caller-identity || aws sso login
end

# function aws_oolio
#   echo "choosing oolio aws profile"
#   set -x AWS_PROFILE "oolio-admin"
#   set -x AWS_REGION ap-southeast-2
#   kubectx oolio-dev
#   aws ecr get-login-password --region ap-southeast-2 | docker login --username AWS --password-stdin 736923576672.dkr.ecr.ap-southeast-2.amazonaws.com
# end
# 
# function aws_till
#   echo "choosing tillx-dev aws profile"
#   set -x AWS_PROFILE tillx-dev-admin
#   set -x AWS_REGION ap-south-1
#   aws eks update-kubeconfig --region ap-south-1 --name till-x-eks
# end
# 
# function aws_till_prod
#   echo "choosing tillx aws profile"
#   set -x AWS_PROFILE tillx-admin
#   set -x AWS_REGION ap-southeast-2
#   aws eks update-kubeconfig --region ap-southeast-2 --name till-x-production
# end


