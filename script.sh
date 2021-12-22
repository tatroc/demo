#!/bin/bash

DIR=$(git diff HEAD~1 --name-only | grep '/' | awk -F '/' '{ print $1 }' | head -n 1)
echo "Working on directory $DIR"


TREE_CLEAN=$(git ls-files --deleted --modified --others --exclude-standard | wc -l)
if [  $TREE_CLEAN -eq 0 ]; then
   echo "Working tree clean"
else
   echo "Working tree is not clean, please commit changes. Exiting..."
   exit 1
fi



if [ -z "$DIR" ]
then
      echo "var \$DIR is empty, exiting..."
      exit 1
else
      echo "var \$DIR is NOT empty"
fi
P=$(PWD)
echo "In directory $P "

cd $DIR
mvn --batch-mode release:prepare
if [ $? -eq 0 ]; then
   echo OK
else
   echo "release:prepare failed"
   exit 1
fi



mvn --batch-mode release:perform
if [ $? -eq 0 ]; then
   echo OK
else
   echo "release:perform failed"
   exit 1
fi

mvn github-release:github-release
if [ $? -eq 0 ]; then
   echo OK
else
   echo "github-release:github-release failed"
   exit 1
fi



#version=$(git describe --tags `git rev-list --tags --max-count=1`)

#NEW_VERSION=$(echo $version | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')
#echo "new tag $NEW_VERSION"
#git tag $NEW_VERSION

#echo "list tags"
#git tag
