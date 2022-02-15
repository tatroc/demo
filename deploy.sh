#!/bin/bash
HASH_FILE="commit_hashes.txt"
ALL_COMMIT_HASH_FILE="all_commit_hashes.txt"
COMMITTED_UNTAGGED_FILES="committed_untagged_files.txt"
DEBUG=1
#export SCM_URL=https://github.com/tatroc/demo.git
#export MVN_URL=https://maven.pkg.github.com/tatroc/demo

COMMIT_HASHES_FILE=hashes.txt 
CHANGED_FILE_LIST=changed_files.txt
TF_DIRECTORY_LIST=tf_directories.txt
COMMIT_MESSAGES_FILE=commit_messages.txt

git config --global http.sslVerify false


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
echo "${FUNCNAME[0]}() :: TEMP WORK DIRECTORY: ${WORK_DIR}"

if [[ ! "${WORK_DIR}" || ! -d "${WORK_DIR}" ]]; then
  echo "${FUNCNAME[0]}() :: Could not create /tmp dir"
  exit 1
fi


BRANCH=$(git rev-parse --abbrev-ref HEAD)
echo "${FUNCNAME[0]}() :: DEBUG :: Current branch is ${BRANCH}"


if [[ "${DEBUG}" == "1" ]]; then
  echo "${FUNCNAME[0]}() :: DEBUG :: Getting hashes"
  git log --oneline --pretty=format:%H master..$BRANCH
  
  echo "${FUNCNAME[0]}() :: DEBUG :: Getting log"
  git log --oneline master..$BRANCH

  echo "${FUNCNAME[0]}() :: DEBUG :: Get master HEAD"
  cat ./.git/refs/heads/master
  echo "${FUNCNAME[0]}() :: DEBUG :: Get current HEAD"
  git branch
  cat ./.git/HEAD
fi

echo "${FUNCNAME[0]}() :: On branch $BRANCH"
echo "${FUNCNAME[0]}() :: Getting all commit hash differences between master and $BRANCH"
git log --oneline --pretty=format:%H master..$BRANCH > "${WORK_DIR}/${COMMIT_HASHES_FILE}"

mapfile -t ARRAY_COMMIT_HASHES < "${WORK_DIR}/${COMMIT_HASHES_FILE}"

# Get commit hashes and commit messages
USE_COMMIT_MESSAGE_FOR_REALSES=false
if [[ "${USE_COMMIT_MESSAGE_FOR_REALSES}" ]]; then
  git log --oneline --pretty=format:"%H,%B" > "${WORK_DIR}/${COMMIT_MESSAGES_FILE}"
fi

#git log --pretty="%D %H" --decorate=short --decorate-refs=refs/tags > "${WORK_DIR}/${ALL_COMMIT_HASH_FILE}"
ls -la "${WORK_DIR}/"


# exec 4<"${WORK_DIR}/${ALL_COMMIT_HASH_FILE}"
# while read -u4 line ; do
#     if [[ "$line" != *"tag"* ]]; then
#         echo "Unable to locate Git tag for commit: $line"
#         echo $line >> "${WORK_DIR}/${HASH_FILE}"
#     else
#         echo "Latest tag found in commit: $line"
#         break
#     fi
# done

if [[ -f  "${WORK_DIR}/${COMMIT_HASHES_FILE}" ]]; then
  # The file is not-empty.
  if [[ "${DEBUG}" == "1" ]]; then
    echo "${FUNCNAME[0]}() :: content of of ${WORK_DIR}/${COMMIT_HASHES_FILE}"
    echo "${FUNCNAME[0]}() :: cat ${WORK_DIR}/${COMMIT_HASHES_FILE}"
    cat "${WORK_DIR}/${COMMIT_HASHES_FILE}"
  fi

  for line in "${ARRAY_COMMIT_HASHES[@]}"
  do
    : 
    if [[ "${DEBUG}" == "1" ]]; then
      echo "${FUNCNAME[0]}() :: git show --pretty=\"format:\" --name-only $line"
    fi
      
    git show --pretty="format:" --name-only $line >> "${WORK_DIR}/${CHANGED_FILE_LIST}"
    # do whatever on "$i" here
  done
  echo "${FUNCNAME[0]}() :: Changed files: cat ${WORK_DIR}/${CHANGED_FILE_LIST}"



  # exec 4<"${WORK_DIR}/${COMMIT_HASHES_FILE}"
  # while read -u4 line ; do

  #     if [[ "${DEBUG}" == "1" ]]; then
  #       #echo "${FUNCNAME[0]}() :: $line"
  #       echo "git show --pretty=\"format:\" --name-only $line"
  #     fi
      
  #     git show --pretty="format:" --name-only $line >> "${WORK_DIR}/${CHANGED_FILE_LIST}"

  # done
else
  # The file is empty.
  echo "${FUNCNAME[0]}() :: No Terraform files were modified"
  echo "${FUNCNAME[0]}() :: ${WORK_DIR}/${CHANGED_FILE_LIST} is empty, nothing to do. exiting..."
  exit 0
fi

echo "${FUNCNAME[0]}() :: working directory $WORK_DIR"


if [[ "${DEBUG}" == "1" ]]; then
  #echo "${FUNCNAME[0]}() :: $line"
  echo "${FUNCNAME[0]}() :: DEBUG :: List of changed files in commits"
  cat "${WORK_DIR}/${CHANGED_FILE_LIST}"
fi

cat "${WORK_DIR}/${CHANGED_FILE_LIST}" | egrep "*.tf|*.tfvars" | grep '/' | sort -u | sed 's:[^/]*$::' | sort -u | uniq -u > "${WORK_DIR}/${TF_DIRECTORY_LIST}"

if [[ "${DEBUG}" == "1" ]]; then
  echo "${FUNCNAME[0]}() :: DEBUG :: Terraform directories with changed files: cat ${WORK_DIR}/${TF_DIRECTORY_LIST}"
fi

echo "${FUNCNAME[0]}() :: Working with directories ${DIRECTORY_LIST[@]}"

if [[ -s "${WORK_DIR}/${TF_DIRECTORY_LIST}" ]]; then
        # The file is not-empty.
        echo "${FUNCNAME[0]}() :: Working with the following TF directories"
        cat "${WORK_DIR}/${TF_DIRECTORY_LIST}"
else
        # The file is empty.
      echo "${FUNCNAME[0]}() :: No Terraform files were modified"
      echo "${FUNCNAME[0]}() :: ${WORK_DIR}/${TF_DIRECTORY_LIST} is empty, nothing to do. exiting..."
      exit 0
fi


echo "${FUNCNAME[0]}() :: Exiting function ${FUNCNAME[0]}()"

}

#getmoduledirectories #$HASH_FILE $ALL_COMMIT_HASH_FILE $COMMITTED_UNTAGGED_FILES


if [[ -z $(git status -s) ]]; then
  getmoduledirectories
else
  echo "Uncommitted files in local git, exiting..."
  echo "git add . && git commit -m 'my message'"
  git status
  exit 1
fi


echo "### Contents of: ${WORK_DIR}/${TF_DIRECTORY_LIST} ###"
cat "${WORK_DIR}/${TF_DIRECTORY_LIST}"

mapfile -t TF_DIRS < "${WORK_DIR}/${TF_DIRECTORY_LIST}"





# echo "Working with TF module directories ${DIRECTORY_LIST[@]}"


# TREE_CLEAN=$(git ls-files --deleted --modified --others --exclude-standard | wc -l)
# if [  $TREE_CLEAN -eq 0 ]; then
#    echo "Working tree clean"
# else
#    echo "Working tree is not clean, please commit changes. Exiting..."
#    git status
#    exit 1
# fi


BASE_DIR=$(pwd)
echo "Base directory ${BASE_DIR}"

#echo "Sleeping for 900 seconds"
#sleep 900

# Package and Push TF modules to repository
for wrkdir in "${TF_DIRS[@]}"
do
    CLOUD=$(echo ${wrkdir} | awk -F '/' '{ print $1 }')
    ARTIFACT_ID=$(echo ${wrkdir} | awk -F '/' '{ print $2 }')
    ARTIFACT_ID_FULL="${CLOUD}-${ARTIFACT_ID}"
    echo "CLOUD: ${CLOUD}"
    echo "ARTIFACT_ID: ${ARTIFACT_ID}"
    echo "ARTIFACT_ID_FULL: ${ARTIFACT_ID_FULL}"
    echo "Working on directory: ${wrkdir}"
    cd $wrkdir

    mvn -e --batch-mode build-helper:released-version release:clean release:prepare release:perform install github-release:github-release -Dmaven.wagon.http.ssl.insecure=true -Dmaven.wagon.http.ssl.allowall=true -Dmaven.wagon.http.ssl.ignore.validity.dates=true
    if [ $? -eq 0 ]; then
        echo OK
    else
        echo "Release failed for module ${wrkdir}"
        exit 1
    fi

    cd ..

done

RELEASE_ACTION=false

if [[ "${RELEASE_ACTION}" == 'true' && "$?" == "0" ]]; then

  if [[ "$?" == "0" ]]; then

    echo "Deployment was successful, merging changes in branch $BRANCH to master"
    git branch
    git checkout master
    git merge $BRANCH

    if [[ "$?" == "1" ]]; then
      echo "Merging $BRANCH into master failed!!!, exiting..."
      git diff
      exit 1
    fi

    git pull --no-edit
    git push

  fi

fi

#version=$(git describe --tags `git rev-list --tags --max-count=1`)

#NEW_VERSION=$(echo $version | awk -F. -v OFS=. 'NF==1{print ++$NF}; NF>1{if(length($NF+1)>length($NF))$(NF-1)++; $NF=sprintf("%0*d", length($NF), ($NF+1)%(10^length($NF))); print}')
#echo "new tag $NEW_VERSION"
#git tag $NEW_VERSION

#echo "list tags"
#git tag
