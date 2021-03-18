#!/bin/sh

sudo apt-get update
sudo apt upgrade -y

if [[ $(arch) = "aarch64" ]] && [ "$lsb_dist" = "ubuntu" ]  ; then
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
	sudo pip3 install 'docker-compose>=1.28'
else
	curl -sSL https://get.docker.com | sh
	sudo pip3 install 'docker-compose>=1.28'
	sudo systemctl start docker
fi
