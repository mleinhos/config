#!/bin/bash

# https://www.linuxbabe.com/cloud-storage/install-dropbox-ubuntu-16-04
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 1C61A2656FB57B7E4DE0F4C1FC918B335044912E

echo "deb [arch=i386,amd64] http://linux.dropbox.com/ubuntu $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/dropbox.list
sudo apt update
sudo apt install dropbox python3-gpgme

# Now, run dropbox
