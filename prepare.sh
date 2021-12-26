#!/bin/bash
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
ls -la /usr/apps/kbs/maven3/
export M2_HOME=/usr/bin
which java
which mvn
env
mvn -v