#!/bin/bash

DIRECTORY_LIST=($(git diff HEAD~1 --name-only | grep '/' | awk -F '/' '{ print $1 }' | sort -u))
declare -p DIRECTORY_LIST

echo "Working with directories ${DIRECTORY_LIST[@]}"

for dir in "${DIRECTORY_LIST[@]}"
do
    echo "item"
    echo "${dir}"
done