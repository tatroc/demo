#!/bin/bash

DEBUG=1

export DEBIAN_FRONTEND="noninteractive"
env
mkdir -p ~/.m2
cp ./mvn-settings.xml ~/.m2/settings.xml
dpkg -s maven || EXIT_CODE=$?
if [ $EXIT_CODE -eq 1 ]; then
    echo "Installing maven"
    apt update
    apt install -y maven
fi

export JAVA_HOME=/usr
export M2_HOME=/usr

if [ $DEBUG == "1" ]; then
    cat ~/.m2/settings.xml
    which java
    which mvn
    env
    update-alternatives --get-selections

    update-alternatives --list java

    update-alternatives --list mvn
fi

mvn -v