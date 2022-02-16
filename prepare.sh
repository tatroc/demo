#!/bin/bash

DEBUG=1

export DEBIAN_FRONTEND="noninteractive"
env
mkdir -p ~/.m2
cp ./mvn-settings.xml ~/.m2/settings.xml
#dpkg -s maven || EXIT_CODE=$?
#if [ $EXIT_CODE -eq 1 ]; then
# cat /etc/os-release | head -1 | awk -F '=' '{ print $2 }' | tr -d '" '

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
if [[ "$AWS_EXECUTION_ENV" == "AWS_ECS_EC2" ]]; then
    apt update
    apt install -y maven
else
    sudo apt update
    sudo apt install -y maven
fi

if [[ -z "$JAVA_HOME" ]]; then
      echo "\$JAVA_HOME is empty"
      export JAVA_HOME=/usr
      "Setting JAVA_HOME to ${JAVA_HOME}"
else
      echo "\$JAVA_HOME is NOT empty"
      echo "\$JAVA_HOME value: $JAVA_HOME"
fi

if [[ -z "$M2_HOME" ]]; then
      echo "\$M2_HOME is empty"
      export M2_HOME=/usr/share/maven
      echo "Setting M2_HOME to ${M2_HOME}"
else
      echo "\$M2_HOME is NOT empty"
      echo "\$M2_HOME value: $M2_HOME"
fi



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