#!/bin/bash 
echo "ОТКРЫТИЕ ПОРТОВ"
sudo ufw allow 8845
sudo ufw allow 6160
sudo ufw allow 8646
sudo ufw allow 31303
sudo ufw allow 9322
sudo ufw allow 7400
sudo ufw allow 7401
sudo ufw allow 7645
sudo ufw allow 8745
sudo iptables -t filter -A INPUT -p tcp --dport 8845 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 6160 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 8646 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 31303 -j ACCEPT
sudo iptables -t filter -A INPUT -p udp --dport 31303 -j ACCEPT
sudo iptables -t filter -A INPUT -p udp --dport 9322 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 7400 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 7401 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 7645 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 7645 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 8745 -j ACCEPT
echo " "
echo " "
echo " "
sudo apt-get update && sudo apt-get upgrade -y
echo " "
echo " "
sudo apt install curl build-essential git screen jq pkg-config libssl-dev libclang-dev ca-certificates gnupg lsb-release -y
echo " "
echo " "
sudo apt-get update
echo " "
echo " "
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose
echo " "
echo " "
docker pull gcr.io/prysmaticlabs/prysm/validator:stable
echo " "
echo " "
docker pull gcr.io/prysmaticlabs/prysm/beacon-chain:stable
echo " "
echo " "
sudo add-apt-repository -y ppa:ethereum/ethereum
echo " "
echo " "
sudo apt-get update
echo " "
echo " "
sudo apt-get install ethereum
echo " "
echo " "
echo " "
geth --http --http.api personal,eth,net,web3,txpool &
echo " "
echo " "
echo " "
openssl rand -hex 32
read -p "ВВЕДИТЕ ВЫВОД КОМАНДЫ ВЫШЕ(СТРОКА СИМОВОЛОВ): " link_openssl
echo " "
echo " "
echo " "
echo "$link_openssl" > /root/jwtsecret
echo " "
echo " "
echo " "
echo "Ключ успешно сохранен в /root/jwtsecret"
echo " "
echo " "
echo "ЗАПУСК КОНТЕЙНЕРА ЗАВИСИМОСТИ BEACON"
echo " "
echo " "
server_ip=$(wget -qO- eth0.me)
echo "http://${server_ip}:3500/eth/v1alpha1/node/syncing"
echo "ДОЛЖЕН ВЫВЕСТИ:  {"syncing":true} после запуска контейнера"
echo "Введите эти команды"
echo "screen –S beacon"
echo "docker run -it \
-v $HOME/.eth2:/data \
--network="host" \
-v /root/jwtsecret:/jwtsecret \
-p 4000:4000 -p 13000:13000 -p 12000:12000/udp \
--name beacon-node \
gcr.io/prysmaticlabs/prysm/beacon-chain:stable \
--datadir=/data \
--jwt-secret=/jwtsecret \
--grpc-gateway-host=0.0.0.0 \
--execution-endpoint=http://http://localhost/:8745"
