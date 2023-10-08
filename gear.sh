#!/bin/bash
tput reset 
tput civis 

echo " "
echo " "
echo "НАЧИНАЕМ УСТАНОВКУ НОДЫ GEAR"
echo " "
echo " "

sudo apt-get update && sudo apt-get upgrade -y

sudo apt install htop mc curl tar wget git make ncdu jq chrony net-tools iotop nload -y

wget --no-check-certificate https://get.gear.rs/gear-nightly-linux-x86_64.tar.xz && \
tar xvfJ gear-nightly-linux-x86_64.tar.xz && \
rm gear-nightly-linux-x86_64.tar.xz
sudo chmod +x gear && sudo mv gear /usr/bin

read -p "ПРИДУМАЙТЕ НАЗВАНИЕ ДЛЯ ВАШЕЙ НОДЫ GEAR: " node_name

# Check if string is empty using -z. For more 'help test'    
if [[ -z "$node_name" ]]; then
    printf '%s\n' "ВЫ НЕ УСТАНОВИЛИ НАЗВАНИЕ ВАШЕЙ НОДЫ"
    exit 1
else
    # If userInput is not empty show what the user typed in and run ls -l
    printf "НАЗВАНИЕ ВАШЕЙ НОДЫ GEAR %s " "$node_name"

echo " "
echo " "
echo "СОЗДАНИЕ СЕРВИС ФАЙЛА"
echo " "
echo " "

sudo tee /etc/systemd/system/gear-node.service > /dev/null <<EOF
[Unit]
Description=Gear-node
After=network-online.target
[Service]
User=$USER
ExecStart=/usr/bin/gear --name '$node_name' --telemetry-url 'ws://telemetry-backend-shard.gear-tech.io:32001/submit 0'
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
fi

sudo systemctl daemon-reload && \
sudo systemctl enable gear-node && \
sudo systemctl restart gear-node
sleep 180
echo " "
echo " "
echo "ДЕЛАЕМ БЭКАП"
echo " "
echo " "
sudo mkdir -p $HOME/backup/gear
sudo cp $HOME/.local/share/gear/chains/gear_staging_testnet_*/network/secret_* $HOME/backup/gear/
echo " "
echo " "

