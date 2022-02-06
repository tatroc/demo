#!/bin/bash

DEBUG=0

export DEBIAN_FRONTEND="noninteractive"

GH_SOURCE_FILE=/etc/apt/sources.list.d/github-cli.list

if [[ -f "$GH_SOURCE_FILE" ]]; then
    echo "$GH_SOURCE_FILE exists."
else
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null
fi


env
mkdir -p ~/.m2
cp ./mvn-settings.xml ~/.m2/settings.xml
#dpkg -s maven || EXIT_CODE=$?
#if [ $EXIT_CODE -eq 1 ]; then

GIT_VER_RELEASE=$(git --version | awk '{ print $3 }' | awk -F '.' '{ print $1 }')
GIT_VER_MAJOR=$(git --version | awk '{ print $3 }' | awk -F '.' '{ print $1 }')
GIT_VER=$GIT_VER_RELEASE.$GIT_VER_MAJOR

if awk "BEGIN {exit !($GIT_VER >= 2.17)}"; then
    echo "Git version requirements met ${GIT_VER_RELEASE}"
else
    echo "Install git version > 2.17"
fi

git config --global user.email "${GIT_AUTHOR_EMAIL}"
git config --global user.name "${GIT_AUTHOR_NAME}"


apt update
echo "Installing github cli"
apt install -y gh

echo "Installing maven"
apt install -y maven


export JAVA_HOME=/usr
export M2_HOME=/usr/share/maven

if [ $DEBUG == "1" ]; then
    cat /etc/os-release
    cat ~/.m2/settings.xml
    which java
    which mvn
    env
    update-alternatives --get-selections

    update-alternatives --list java

    update-alternatives --list mvn
fi

mvn -v