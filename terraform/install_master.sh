#!/bin/bash

wget -O - https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" | sudo tee /etc/apt/sources.list.d/saltstack.list
sudo apt-get -y update
sudo apt-get -y install salt-master salt-syndic
sudo systemctl start salt-master
sudo systemctl start salt-syndic

sudo apt-get -y install salt-api gcc python-pip
sudo pip install PyOpenSSL CherryPy