#!/bin/bash

DIR=$(git diff HEAD~1 --name-only | grep '/' | awk -F '/' '{ print $1 }' | head -n 1)
echo $DIR

if [ -z "$DIR" ]
then
      echo "var \$DIR is empty"
      exit 1
else
      echo "var \$DIR is NOT empty"
fi
P=$(PWD)
echo "In directory $P "

cd $DIR
mvn --batch-mode release:prepare
mvn --batch-mode release:perform


#version=$(git describe --tags `git rev-list --tags --max-count=1`)

#NEW_VERSION=$(echo $version | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')
#echo "new tag $NEW_VERSION"
#git tag $NEW_VERSION

#echo "list tags"
#git tag
