#!/bin/bash

DEBUG=0

export DEBIAN_FRONTEND="noninteractive"
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


echo "Installing maven"
apt update
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