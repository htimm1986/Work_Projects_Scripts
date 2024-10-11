#!/bin/bash
#author ["Hampton Timm <hampton.timm@mihin.org"]

#check poetry install exit if not installed w/message
if command -v poetry > /dev/null; then
    :
else
    echo "poetry is not installed"
    exit 1
fi

#grep python version from sonar-project.properties/pyproject.toml, exit if none, if found python3 env change
if grep -Po 'sonar.python.version\D*\K\d[\d.]*' sonar-project.properties ; then
    my_pyth=$(grep -Po 'sonar.python.version\D*\K\d[\d.]*' sonar-project.properties)
elif grep -Po 'python =\D*\K\d[\d.]*' pyproject.toml ; then
    my_pyth=$(grep -Po 'python =\D*\K\d[\d.]*' pyproject.toml)
else
    echo "Not in a python repo"
    exit
fi

echo 'Python3 version required:' $my_pyth
current_pyth=$(python3 -V)

if [ "Python $my_pyth" = "$current_pyth" ]; then
    :
else
    echo 'Install python' ${my_pyth}
    exit
fi

python{$my_pyth} -m venv .venv

#Activate python3 .venv
echo "Activating venv"
source .venv/bin/activate

#check for pyproject.toml
if  find pyproject.toml > /dev/null; then
    poetry lock
    poetry install
fi

#check for requirements.txt
if find requirements.txt > /dev/null; then
    :
else
    pip3 install -r requirements.txt
fi 