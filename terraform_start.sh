#!/bin/bash
#author ["Hampton Timm <hampton.timm@mihin.org"]

#check directory, remove terraform files, switch, init
if find *.tf > /dev/null; then
    rm -rf .terraform*
    echo "terraform switch and initialize"
    tfswitch
    terraform init
else
    echo "No .tf files found"
    exit 1
fi

#list workspace and choose
terraform workspace list
echo "Which workspace? :" 
read workspace_choice

#select workspace
terraform workspace select $workspace_choice
