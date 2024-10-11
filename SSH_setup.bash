#!/bin/bash
#author ["Hampton Timm <hampton.timm@mihin.org"]

#HELP
Help()
{
    #Display Help
    echo "This script installs and sets up an SSH client for SSL connection to bitbucket."
    echo "You must pass -n along with your work email to generate the keys."
}

#define -u option
while getopts "u:h" option; do
    case $option in
        u) email="$OPTARG";;
        h) Help;;
    esac
done

#update linux and install openssh
cd ~
sudo apt update && sudo apt install openssh-client

#check status of ssh-agent
ps -ax | grep ssh-agent
eval $(ssh-agent)

#add command to ~/.bashrc
echo 'eval $(ssh-agent)' >> ~/.bashrc

#generate SHA key pair and define key name
ssh-keygen -t ed25519 -b 4096 -C "$email" -f bitbucket_key

#add key to SSH agen
ssh-add ~/bitbucket_key

#create .ssh/config file and add host/key info
mkdir .ssh && touch .ssh/config
echo "Host bitbucket.org" >> ~/.ssh/config
echo "AddKeysToAgent yes" >> ~/.ssh/config
echo "IdentityFile ~/.ssh/bitbucket_key" >> ~/.ssh/config

#Text instructions for public key
echo "This is your public key."
echo "It is required for SSL connection to bitbucket."
echo "Open a web browser and navigate to bitbucket.org"
echo "Log in to your organization, click the settings cog, then select Personal Bitbucket settings."
echo "Select SSH key and then Add Key. Copy and paste the entire key below then select Add Key."
cat bitbucket_key.pub

#Prompt for completion of adding public key to bitbucket then testing connection
read -a "Have you completed the above steps? Type yes when complete: "
ssh -T git@bitbucket.org
