#!/bin/bash
tput reset
tput civis

docker stop muon-node mongo redis
docker rm muon-node mongo redis

sudo ufw allow 8011
sudo ufw allow 9011
iptables -A INPUT -p tcp --dport 8011 -j ACCEPT
iptables -A INPUT -p tcp --dport 9011 -j ACCEPT

curl -o docker-compose.yml https://raw.githubusercontent.com/muon-protocol/muon-node-js/alice-v2/docker-compose-pull.yml

docker compose pull
sleep 90

docker compose up -d

curl http://localhost:8011/status
