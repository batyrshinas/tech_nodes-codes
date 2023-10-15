#!/bin/bash
tput reset 
tput civis 

echo " "
echo "УСТАНОВКА ПРЕРЕКВИЗИТОВ"
echo " "
sudo apt-get install curl -y
sudo apt update
sudo apt install docker.io -y
docker --version
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

echo " "
echo "НАЧИНАЕМ УСТАНОВКУ НОДЫ SHARDEUM"
echo " "

cd $HOME

sudo apt update && sudo apt upgrade -y
sudo apt install make clang git pkg-config libssl-dev build-essential git gcc chrony curl jq ncdu bsdmainutils htop net-tools lsof fail2ban wget -y
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh

echo "******************* УСТАНОВКА НОДЫ ЗАВЕРШЕНА *******************"
echo "Для запуска ноды перейдите по ссылке https://your_server_ip:8080"
