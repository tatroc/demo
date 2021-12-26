#!/bin/bash
HASH_FILE="commit_hashes.txt"
ALL_COMMIT_HASH_FILE="all_commit_hashes.txt"
COMMITTED_UNTAGGED_FILES="committed_untagged_files.txt"
DEBUG=1
#export SCM_URL=https://github.com/tatroc/demo.git
#export MVN_URL=https://maven.pkg.github.com/tatroc/demo




if [[ -z "${SCM_URL}" ]]; then
  echo "environment variable \$SCM_URL not set"
  echo "run: source ./env.vars"
  exit 1
else
    echo "environment variable \$SCM_URL set to ${SCM_URL}"
fi

if [[ -z "${MVN_URL}" ]]; then
  echo "environment variable \$MVN_URL not set"
  echo "run: source ./env.vars"
  exit 1
else
    echo "environment variable \$MVN_URL set to ${MVN_URL}"
fi

if [[ -z "${GITHUB_USERNAME}" ]]; then
  echo "environment variable \$GITHUB_USERNAME not set"
  exit 1
else
    echo "environment variable \$GITHUB_USERNAME set to ${GITHUB_USERNAME}"
fi

if [[ -z "${GITHUB_PASSWORD}" ]]; then
  echo "environment variable \$GITHUB_PASSWORD not set"
  exit 1
else 
    echo "environment variable \$GITHUB_PASSWORD set to XXXXXXXXXX"
fi


if [ $DEBUG == "1" ]; then
    which git
    git --version
fi



function getmoduledirectories {

WORK_DIR=$(mktemp -d -p "/tmp")
git branch
echo "TEMP WORK DIRECTORY: ${WORK_DIR}"

if [[ ! "${WORK_DIR}" || ! -d "${WORK_DIR}" ]]; then
  echo "Could not create /tmp dir"
  exit 1
fi

git log --pretty="%D %H" --decorate=short --decorate-refs=refs/tags > "${WORK_DIR}/${ALL_COMMIT_HASH_FILE}"
ls -la "${WORK_DIR}/"


exec 4<"${WORK_DIR}/${ALL_COMMIT_HASH_FILE}"
while read -u4 line ; do
    if [[ "$line" != *"tag"* ]]; then
        echo "No tag found in commit: $line"
        echo $line >> "${WORK_DIR}/${HASH_FILE}"
    else
        echo "Latest tag found in commit: $line"
        break
    fi
done

cat "${WORK_DIR}/${HASH_FILE}"

exec 4<"${WORK_DIR}/${HASH_FILE}"
while read -u4 line ; do
    echo "$line"

    git show --pretty="format:" --name-only $line >> "${WORK_DIR}/${COMMITTED_UNTAGGED_FILES}"
done

cat "${WORK_DIR}/${COMMITTED_UNTAGGED_FILES}"

DIRECTORY_LIST=($(cat ${WORK_DIR}/${COMMITTED_UNTAGGED_FILES} | egrep -v "*.xml|^\." | grep '/' | awk -F '/' '{ print $1 }' | sort -u))
declare -p DIRECTORY_LIST


echo "Working with directories ${DIRECTORY_LIST[@]}"


if [ -z "$DIRECTORY_LIST" ]
then
    echo "No TF modules were modified"
    echo "\$DIRECTORY_LIST is empty, nothing to do. Exiting..."
    exit 0
else
    echo "\$DIRECTORY_LIST is NOT empty"
fi

echo "Working with directories ${DIRECTORY_LIST[@]}"

for dir in "${DIRECTORY_LIST[@]}"
do
    echo "Directory: ${dir}"
done

echo $WORK_DIR
}

getmoduledirectories $HASH_FILE $ALL_COMMIT_HASH_FILE $COMMITTED_UNTAGGED_FILES


echo "Working with TF module directories ${DIRECTORY_LIST[@]}"


TREE_CLEAN=$(git ls-files --deleted --modified --others --exclude-standard | wc -l)
if [  $TREE_CLEAN -eq 0 ]; then
   echo "Working tree clean"
else
   echo "Working tree is not clean, please commit changes. Exiting..."
   git status
   exit 1
fi



# if [ -z "$DIRECTORY_LIST" ]
# then
#       echo "var \$DIRECTORY_LIST is empty, exiting..."
#       exit 1
# else
#       echo "var \$DIRECTORY_LIST is NOT empty"
# fi
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
