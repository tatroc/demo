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
    echo "Git version requirements met"
else
    echo "Install git version > 2.17"
fi


    echo "Installing maven"
#    apt update
#    apt install -y software-properties-common
#    apt update
#    add-apt-repository ppa:git-core/ppa -y
    apt update
    #apt install -y -t buster-backports git
    apt install -y maven # git
    
#    apt -y --only-upgrade install git
#fi

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