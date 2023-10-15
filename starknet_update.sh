#!/bin/bash
echo " ОБНОВЛЯЕМ НОДУ STARKNET"
systemctl stop starknetd.service
#sudo apt update && sudo apt-get install software-properties-common -y
#sudo add-apt-repository ppa:deadsnakes/ppa -y
#sudo apt update && sudo apt install curl git tmux python3.10 python3.10-venv python3.10-dev build-essential libgmp-dev pkg-c
onfig libssl-dev -y
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
source $HOME/.bash_profile
rustup update stable --force

cd ~/pathfinder
git pull
git fetch --all
git checkout v0.8.2
cargo build --release --bin pathfinder
mv ~/pathfinder/target/release/pathfinder /usr/local/bin/

echo "[Unit]
Description=StarkNet
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/pathfinder --http-rpc=\"0.0.0.0:9545\" --ethereum.url \"$ALCHEMY\"
Restart=on-failure
systemctl start starknetd.service
sleep 10
systemctl status starknetd.service
