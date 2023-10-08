#!/bin/bash
tput reset
tput civis

mkdir -p $HOME/cometbft_folder
cd $HOME/cometbft_folder
wget -O cometbft.tar.gz https://github.com/cometbft/cometbft/releases/download/v0.37.2/cometbft_0.37.2_linux_amd64.tar.gz
tar xvf cometbft.tar.gz
sudo chmod +x cometbft
sudo mv ./cometbft /usr/local/bin/

cometbft version
