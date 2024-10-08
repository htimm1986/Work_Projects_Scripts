#!/bin/bash
### check poetry install exit if not installed w/message ###
echo "verifying poetry install"
if command -v poetry > /dev/null; then
    echo "poetry is installed on the system"
else
    echo "poetry is not installed"
    exit 1
fi
#check for specific poetry pyproject.toml#
if  find pyproject.toml > /dev/null; 
    
else
    echo "pyproject.toml does not exist"
    exit 1
fi
#check for version requirements.txt and pip3 install# 
if find requirements.txt > /dev/null;
    
else
    echo "requirements.txt does not exist"
    exit 1
fi 
### python3 env change###
my_pyth=$(grep -Po "(?<=sonar.python.version=)([0-9]|\.)*(?=\s|$)" sonar-project.properties)
echo 'Python3 version required:' $my_pyth
python{$my_pyth} -m venv .venv
### Activate pyton3 .venv###
echo "Activating venv"
source .venv/bin/activate
#poetry and pip3 install#
poetry install pyproject.toml
pip3 install -r requirements.txt
