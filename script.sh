#!/bin/bash

git diff HEAD~1 --name-only | grep '/' | awk -F '/' '{ print $1 }' | head -n 1
