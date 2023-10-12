#!/bin/bash
tput reset 
tput civis 

echo "  "
echo "  "

echo "УСТАНАВЛИВАЕМ БИНАРНИК"
echo "  "
echo "  "
cd $HOME
wget "https://github.com/subspace/pulsar/releases/download/v0.6.14-alpha/pulsar-ubuntu-x86_64-skylake-v0.6.14-alpha"
sleep 15
sudo chmod +x pulsar-ubuntu-x86_64-skylake-v0.6.13-alpha
echo "  "
echo "  "
echo "УСТАНАВЛИВАЕМ SCREEN"
sudo apt-get install screen
sleep 15
echo "  "
echo "  "
echo "ДАЛЕЕ НЕОБХОДИМО ВВЕСТИ АДРЕС КОШЕЛЬКА POLKADOT.JS ИЛИ SUBWALLET И НАЗВАНИЕ НОДЫ. ОСТАЛЬНЫЕ ШАГИ ОСТАВЛЯЕМ ПО УМОЛЧАНИЮ (НАЖИМАЕМ ENTER)"
echo "  "
echo "  "
sudo ./pulsar-ubuntu-x86_64-skylake-v0.6.14-alpha  init
screen -S farming
