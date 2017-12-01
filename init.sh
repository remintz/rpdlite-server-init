#!/bin/bash

echo -e "--------------------------------------------------------------------------"
echo -e "Initializing new RPDLite Server"
echo -e "--------------------------------------------------------------------------"


REPO_DIR=$(pwd)
TMP_DIR=~
HOME_DIR=/home/admin

#####################################################################################
## RERESH SYSTEM WITH APT-GET LIBRARY UPDATE & UPGRADE
#####################################################################################
echo -e " Updating APT-GET libraries and installed packages..."
echo -e "--------------------------------------------------------------------------"
apt-get -y update 							# Update library

#####################################################################################
## Install docker (see https://docs.docker.com/engine/installation/linux/docker-ce/debian/#install-docker-ce-1)
#####################################################################################
apt-get -y install \
     apt-transport-https \
     ca-certificates \
     curl \
     gnupg2 \
     software-properties-common
curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get -y install docker-ce=17.09.0~ce-0~debian
usermod -aG docker admin
cd $HOME_DIR
sudo cp -f $REPO_DIR/run_docker_server.sh $HOME_DIR/run_docker_server.sh
sudo chmod 0755 $HOME_DIR/run_docker_server.sh
#--- add docker to run when boot
sudo crontab -l -u root | cat - $REPO_DIR/cron-reboot-entry-docker | sudo crontab -u root -
#--- copy node-red initial files
mkdir $HOME_DIR/node-red-user-data
cp -r $REPO_DIR/node-red-files/* $HOME_DIR/node-red-user-data/

#####################################################################################
## Reboot the machine
#####################################################################################

echo -e "--------------------------------------------------------------------------"
echo -e " The RPDlite Server is going to reboot now!"
echo -e "--------------------------------------------------------------------------"
sleep 5
shutdown -r now
