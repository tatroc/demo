HASH_FILE="commit_hashes.txt"
ALL_COMMIT_HASH_FILE="all_commit_hashes.txt"

COMMITTED_UNTAGGED_FILES="committed_untagged_files.txt"

function getmoduledirectories {

WORK_DIR=$(mktemp -d -p "/tmp")
if [[ ! "${WORK_DIR}" || ! -d "${WORK_DIR}" ]]; then
  echo "Could not create temp dir"
  exit 1
fi

git log --pretty="%D %H" --decorate=short --decorate-refs=refs/tags > "${WORK_DIR}/${ALL_COMMIT_HASH_FILE}"

exec 4<"${WORK_DIR}/${ALL_COMMIT_HASH_FILE}"
echo Start
while read -u4 line ; do
    echo "$line"

    if [[ "$line" != *"tag"* ]]; then
        echo "It's there. $line"
        echo $line >> "${WORK_DIR}/${HASH_FILE}"
    else
        echo "tag found in line $line"
        break
    fi
done

cat "${WORK_DIR}/${HASH_FILE}"

exec 4<"${WORK_DIR}/${HASH_FILE}"
echo Start
while read -u4 line ; do
    echo "$line"

    git show --pretty="format:" --name-only $line >> "${WORK_DIR}/${COMMITTED_UNTAGGED_FILES}"
done

cat "${WORK_DIR}/${COMMITTED_UNTAGGED_FILES}"

DIRECTORY_LIST=($(cat ${WORK_DIR}/${COMMITTED_UNTAGGED_FILES} | grep '/' | awk -F '/' '{ print $1 }' | sort -u))
declare -p DIRECTORY_LIST

echo "Working with directories ${DIRECTORY_LIST[@]}"

for dir in "${DIRECTORY_LIST[@]}"
do
    echo "item"
    echo "${dir}"
done


echo "Working with TF module directories ${DIRECTORY_LIST[@]}"

echo $WORK_DIR
}

getmoduledirectories $HASH_FILE $ALL_COMMIT_HASH_FILE $COMMITTED_UNTAGGED_FILES