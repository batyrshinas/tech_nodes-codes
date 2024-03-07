#!/bin/bash
tput reset 
tput civis 

echo " "
echo " "
echo "---DELETE OLD NODE---"
docker stop muon-node mongo redis
docker rm muon-node mongo redis
sleep 60
echo " "
echo " "
sudo apt install docker-compose


echo "---ADD ACCEPT RULES TO FIREWALL---"
iptables -A INPUT -p tcp --dport 8011 -j ACCEPT
iptables -A INPUT -p tcp --dport 9011 -j ACCEPT
iptables -A INPUT -p tcp --dport 8012 -j ACCEPT
iptables -A INPUT -p tcp --dport 9012 -j ACCEPT

echo " "
echo " "
echo "---- PREPARE ----"
cd $HOME
mkdir pion-docker
cd pion-docker
echo " "
echo " "
echo "---GET PION---"

curl -o docker-compose.yml https://raw.githubusercontent.com/muon-protocol/muon-node-js/pion/docker-compose-pull.yml
sudo docker-compose pull
sudo docker-compose up -d
echo " "
echo " "

ip_address=$(wget -qO- eth0.me)

echo "ПРОВЕРКА НОДЫ"
echo " "
echo " "
sleep 60
curl http://$ip_address:8012/status
docker ps -a


