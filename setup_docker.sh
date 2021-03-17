#!/bin/bash

sudo apt-get update
sudo apt upgrade -y

if [[ $(arch) = "aarch64" ]]; then
	sudo apt-get install -y \
    	apt-transport-https \
    	ca-certificates \
    	curl \
    	gnupg
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
	sudo rm /etc/apt/sources.list.d/docker.list
	echo \
 	 "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  	$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update
	sudo apt-get install -y docker-ce docker-ce-cli containerd.io
	sudo pip3 install docker-compose
	sudo systemctl start docker
else
	sudo apt-get purge docker-ce docker-ce-cli containerd.io
	sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
	curl -fsSL https://get.docker.com -o get-docker.sh	
	sudo sh get-docker.sh
	sudo rm get-docker.sh
	sudo systemctl status docker
fi
