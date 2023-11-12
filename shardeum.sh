#!/bin/bash
tput reset 
tput civis 
your_server_ip=$(wget -qO- eth0.me)
echo " "
echo " "
echo "УСТАНОВКА ПРЕРЕКВИЗИТОВ"
echo " "
echo " "
sudo apt-get install curl -y
sudo apt update
sudo apt install docker.io -y
docker --version
sudo curl -L "https://github.com/docker/compose/releases/download/2.23.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo docker-compose --version
sudo apt install make clang git pkg-config libssl-dev build-essential git gcc chrony curl jq ncdu bsdmainutils htop net-tools lsof fail2ban wget -y

echo " "
echo " "
echo "НАЧИНАЕМ УСТАНОВКУ НОДЫ SHARDEUM"
echo " "
echo " "

cd $HOME
sudo apt update && sudo apt upgrade -y
sudo curl -O "https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh" && chmod +x installer.sh && ./installer.sh

echo " "
echo " "
echo "ЗАПУСК ВАДИДАТОРА SHARDEUM"
echo " "
echo " "
cd $HOME
cd .shardeum
./shell.sh
operator-cli gui start
operator-cli start
operator-cli status
exit
cd $HOME

echo "******************* УСТАНОВКА НОДЫ ЗАВЕРШЕНА *******************"
echo "Для запуска ноды перейдите на дашборд по ссылке https://$your_server_ip:8080"
