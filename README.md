# rpdlite-server-init
Script to install the DIY IoT Prototyping Platform orchestration server

It runs on Debian Jessie Linux.

Suggestion: create the smallest AWS Lightsail instance and run the following commands:

```
sudo apt-get update
sudo apt-get install git
git clone https://github.com/remintz/rpdlite-server-init
cd rpdlite-server-init
sudo bash init.sh
```

This will install docker and reboot the machine.

After restarting it will automaticall pull and run the containers.

Connect to the Node-RED IDE pointing your web browser to the server IP address.

For more info send an e-mail to renato.mintz@accenture.com

You are more than welcome to submit pull requests.

