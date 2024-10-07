#!/bin/bash
### python3 env change###
echo 'Current Python version :'
python3 --version
python3 -m venv 3.9
### Activate pyton3 .venv###
echo "Activating venv"
source .venv/bin/activate
#check for specific poetry package.json#
echo "cheking for package.json"
if  find ~/repos -name package.json; then
    echo 'package.json exists in repo path above'
else
    echo "package.json does not exist"
fi
### check poetry install exit if not installed w/message ###
echo "verifying poetry install"
if command -v poetry > /dev/null; then
    echo "poetry is installed on the system"
else
    echo "poetry is not installed"
    exit
fi
echo 'Your poetry version:'
poetry --version
#check for version requirements.txt# 
echo "checking for requirements.txt file"
if find ~/repos -name requirements.txt; then
    echo "requirements.txt exists in repo path above"
else
    echo "requirements.txt does not exist"
fi 
