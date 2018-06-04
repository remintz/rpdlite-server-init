# DIY Iot Prototyping Platform - Server side

This is the DIY IoT Prototyping Kit code for the server side.

## Deploying the server
1. Deploy a Debian 512MB Server on AWS Lightsail
2. On the server run the following commands:

`sudo apt-get update
sudo apt-get install git
git clone https://github.com/remintz/rpdlite-server-init.git
cd rpdlite-server-init
sudo bash init.sh
`

This will install docker and a startup script on crontab that will run on every reboot. The startup script will pull docker containers for Node-RED and MongoDB and run them.

You may access the Node-RED IDE pointing your browser to the server external IP address.

## Building the Docker container
This repo also includes the Dockerfile to build the Node-RED docker container.

> Written with [StackEdit](https://stackedit.io/).