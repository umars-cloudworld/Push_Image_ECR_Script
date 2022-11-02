#!/bin/bash
Account=$(aws sts get-caller-identity --query "Account" --output text)
UserId=$(aws sts get-caller-identity --query "UserId" --output text)
Arn=$(aws sts get-caller-identity --query "Arn" --output text)
echo "Account: $Account"
echo "UserId: $UserId"
echo "Arn: $Arn"
REGION="us-east-1"
IMAGE="multi-client"
#Choose any of the tag you want
LATEST="latest"
PRODTAG="production-1"
STAGGINNGTAG="stagging-1"
DEVELOPMENTTAG="development-1"
echo $REGION
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $Account.dkr.ecr.$REGION.amazonaws.com
docker build -t $IMAGE .
docker tag $IMAGE:$LATEST $Account.dkr.ecr.$REGION.amazonaws.com/$IMAGE:$LATEST
docker push $Account.dkr.ecr.$REGION.amazonaws.com/$IMAGE:$LATEST
echo "CONGRATULATIONS! Image has been successfully uploaded to the ECR"