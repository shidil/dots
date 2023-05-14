# login to ECR registry of current aws profile
function ecr
    set region $(aws configure get region)
    set account $(aws ecr describe-registry --query registryId --output text)
    set registry "$account.dkr.ecr.$region.amazonaws.com"
    set ecrpass $(aws ecr get-login-password --region $region)
    echo $ecrpass | $argv[1] login --username AWS --password-stdin $registry
end
