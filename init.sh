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
## Install docker
#####################################################################################
apt-get -y install curl
curl -sSL https://get.docker.com | sh
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
