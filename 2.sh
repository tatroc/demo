#!/bin/bash

HASH_FILE="commit_hashes.txt"
ALL_COMMIT_HASH_FILE="./all_commit_hashes.txt"

COMMITTED_UNTAGGED_FILES="committed_untagged_files.txt"

if [ -f $HASH_FILE ] ; then
    rm $HASH_FILE
fi
if [ -f $ALL_COMMIT_HASH_FILE ] ; then
    rm $ALL_COMMIT_HASH_FILE
fi
if [ -f $COMMITTED_UNTAGGED_FILES ] ; then
    rm $COMMITTED_UNTAGGED_FILES
fi

#NOT_PUSHED=$(git push --dry-run --porcelain | sed -n '2 p' | awk '{ print $2 }')

git log --pretty="%D %H" --decorate=short --decorate-refs=refs/tags > $ALL_COMMIT_HASH_FILE




exec 4<"$ALL_COMMIT_HASH_FILE"
echo Start
while read -u4 line ; do
    echo "$line"

    if [[ "$line" != *"tag"* ]]; then
        echo "It's there. $line"
        echo $line >> $HASH_FILE
    else
        echo "tag found in line $line"
        break
    fi
done

cat ./$HASH_FILE


#DIRECTORY_LIST=$(git show --pretty="format:" --name-only $NOT_PUSHED | awk NF | grep '/' | awk -F '/' '{ print $1 }' | sort -u)


#DIRECTORY_LIST=($(git diff HEAD~1 --name-only | grep '/' | awk -F '/' '{ print $1 }' | sort -u))
#declare -p DIRECTORY_LIST

#echo "Working with directories ${DIRECTORY_LIST[@]}"

#for dir in "${DIRECTORY_LIST[@]}"
#do
#    echo "item"
#    echo "${dir}"
#done

exec 4<"$HASH_FILE"
echo Start
while read -u4 line ; do
    echo "$line"

    git show --pretty="format:" --name-only $line >> $COMMITTED_UNTAGGED_FILES
done


cat $COMMITTED_UNTAGGED_FILES


DIRECTORY_LIST=($(cat $COMMITTED_UNTAGGED_FILES | grep '/' | awk -F '/' '{ print $1 }' | sort -u))
declare -p DIRECTORY_LIST

echo "Working with directories ${DIRECTORY_LIST[@]}"

for dir in "${DIRECTORY_LIST[@]}"
do
    echo "item"
    echo "${dir}"
done
