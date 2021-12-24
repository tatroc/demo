#!/bin/bash
mkdir -p ~/.m2
cp ./mvn-settings.xml ~/.m2/settings.xml
dpkg -s maven || EXIT_CODE=$?
if [ $EXIT_CODE -eq 1 ]; then
    echo "Installing maven"
    apt update
    apt install -y maven
fi
mvn -v