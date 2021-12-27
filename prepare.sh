#!/bin/bash

DEBUG=1

export DEBIAN_FRONTEND="noninteractive"
env
mkdir -p ~/.m2
cp ./mvn-settings.xml ~/.m2/settings.xml
#dpkg -s maven || EXIT_CODE=$?
#if [ $EXIT_CODE -eq 1 ]; then

GIT_VER_RELEASE=$(git --version | awk '{ print $3 }' | awk -F '.' '{ print $1 }')
GIT_VER_MAJOR=$(git --version | awk '{ print $3 }' | awk -F '.' '{ print $1 }')
GIT_VER=$GIT_VER_RELEASE.$GIT_VER_MAJOR

st=$(echo "2.17 < $GIT_VER" | bc)

if [ $st -eq 1]; then
  echo -e "$num1 < $num2 , Install git version > 2.17"
  exit 1
else
  echo -e "$num1 >= $num2"
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