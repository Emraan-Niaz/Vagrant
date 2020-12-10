#!/bin/bash
#Hier kommt Bockwurst rein
apt-get update
apt-get -y upgrade
apt-get -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common #Installs the certificates
curl -fsSl https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -    #Downloads the docker for ubuntu
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" #Downloads the docker
apt-get update
apt-get -y install docker-ce docker-ce-cli containerd.io #install the downloaded Docker
#to check the version of Docker: apt-cache madison docker-ce
usermod -aG docker vagrant
systemctl enable docker #enable our docker
#to check the docker response use: vagrant@gitlab:~$ docker run hello-world
mkdir -p /srv/gitlab/{data,logs.config } #nötige Verzeichniss erstellen
# Gitlab-Ce Container erstellen
docker run --detach \
--hostname gitlab \
--publish 80:80 \
--name gitlab \
--restart always \
--volume /srv/gitlab/config:/etc/gitlab \
--volume /srv/gitlab/logs:/var/log/gitlab \
--volume /srv/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest

