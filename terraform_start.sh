#!/bin/bash
#check directory, remove terraform files, switch, init#
if find *.tf > /dev/null; then
        rm -rf .terraform*
        echo "terraform switch and intialize"
        tfswitch
        terraform init
else
    echo "No .tf files found"
    exit 1
fi
#show workspace and choose#
terraform workspace show
echo "Which workspace? :" 
read workspace_choice
#select workspace#
terraform workspace select $workspace_choice
