#!/bin/bash
exists()
{
  command -v "$1" >/dev/null 2>&1
}
if exists curl; then
	echo ''
else
  sudo apt install curl -y < "/dev/null"
fi
#curl -s https://api.nodes.guru/logo.sh | bash
#echo "==================================================="
sleep 2

read -p "ВВЕДИТЕ ВАШ ALCHEMY API KEY (МОЖНО НАЙТИ НАЖАВ на VIEW KEY НА САЙТЕ https://dashboard.alchemy.com/apps): " API && sleep 2
ALCHEMY=https://eth-sepolia.g.alchemy.com/v2/$API
echo 'export ALCHEMY='$ALCHEMY >> $HOME/.bash_profile


sudo apt update && sudo apt install pkg-config libssl-dev libzstd-dev protobuf-compiler -y
#sudo add-apt-repository ppa:deadsnakes/ppa -y
#sudo apt update && sudo apt install curl git tmux python3.10 python3.10-venv python3.10-dev build-essential libgmp-dev pkg-config libssl-dev -y
sudo curl https://sh.rustup.rs -sSf | sh -s -- -y
source $HOME/.cargo/env
source $HOME/.bash_profile
rustup update stable --force

cd ~/pathfinder
git pull
git fetch --all
git checkout v0.10.3
cargo build --release --bin pathfinder
sudo mv ~/pathfinder/target/release/pathfinder /usr/local/bin/
mkdir -p $HOME/.starknet/db

echo "[Unit]
Description=StarkNet
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/pathfinder --http-rpc=\"0.0.0.0:9545\" --ethereum.url \"$ALCHEMY\" --data-directory \"$HOME/.starknet/db\"
Restart=on-failure
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/starknetd.service
sudo mv $HOME/starknetd.service /etc/systemd/system/

#cd py
#python3.10 -m venv .venv
#source .venv/bin/activate
#PIP_REQUIRE_VIRTUALENV=true pip install -r requirements-dev.txt
#pip install --upgrade pip
sudo systemctl daemon-reload
sudo systemctl restart starknetd


echo -e "\e[32mYour node version\e[39m" $(pathfinder -V)
