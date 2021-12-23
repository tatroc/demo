#!/bin/bash

DIRECTORY_LIST=($(git diff HEAD~1 --name-only | grep '/' | awk -F '/' '{ print $1 }' | sort -u))
declare -p DIRECTORY_LIST

echo "Working with directories ${DIRECTORY_LIST[@]}"


TREE_CLEAN=$(git ls-files --deleted --modified --others --exclude-standard | wc -l)
if [  $TREE_CLEAN -eq 0 ]; then
   echo "Working tree clean"
else
   echo "Working tree is not clean, please commit changes. Exiting..."
   git status
   exit 1
fi



if [ -z "$DIRECTORY_LIST" ]
then
      echo "var \$DIRECTORY_LIST is empty, exiting..."
      exit 1
else
      echo "var \$DIRECTORY_LIST is NOT empty"
fi
BASE_DIR=$(pwd)
echo "Base directory ${BASE_DIR}"

# Package and Push TF modules to repository
for wrkdir in "${DIRECTORY_LIST[@]}"
do
    echo "Working on directory: ./${wrkdir}"
    cd $wrkdir

    mvn --batch-mode build-helper:released-version release:clean release:prepare release:perform install github-release:github-release
    if [ $? -eq 0 ]; then
        echo OK
    else
        echo "release failed for module ${wrkdir}"
        exit 1
    fi

    cd ..

done

#version=$(git describe --tags `git rev-list --tags --max-count=1`)

#NEW_VERSION=$(echo $version | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')
#echo "new tag $NEW_VERSION"
#git tag $NEW_VERSION

#echo "list tags"
#git tag
