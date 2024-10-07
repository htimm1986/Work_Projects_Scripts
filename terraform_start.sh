#!/bin/bash
#check directory, remove terraform files, switch, init#
if [ $PWD = $HOME/repos ]; then
        echo "You are in the correct directory"
        rm -rf .terraform*
        echo "terraform switch and intialize"
        tfswitch
        terraform init
else
    echo "You are not in ~/repos"
    exit 1
fi
#show workspace and choose#
terraform workspace show
echo "Which workspace? :" 
read workspace_choice
#select workspace#
terraform workspace select $workspace_choice
