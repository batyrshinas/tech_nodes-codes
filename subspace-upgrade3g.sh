#!/bin/bash
tput reset 
tput civis 

echo "  "
echo "  "

echo "ОСТАНАВЛИВАЕМ СЕРВИС"
echo "  "
echo "  "
systemctl stop subspaced.service
sudo rm /usr/local/bin/subspace-cli

echo "  "
echo "  "
echo "ОБНОВЛЕНИЕ БИНАРНИКА"
echo "  "
echo "  "
cd $HOME
wget -O subspace-cli "https://github.com/subspace/pulsar/releases/download/v0.6.14-alpha/pulsar-ubuntu-x86_64-skylake-v0.6.14-alpha"
sleep 15
sudo chmod +x subspace-cli
sudo mv subspace-cli /usr/local/bin/
echo "  "
echo "  "
echo "ДАЛЕЕ НЕОБХОДИМО ВВЕСТИ АДРЕС КОШЕЛЬКА POLKADOT.JS ИЛИ SUBWALLET И НАЗВАНИЕ НОДЫ. ОСТАЛЬНЫЕ ШАГИ ОСТАВЛЯЕМ ПО УМОЛЧАНИЮ (НАЖИМАЕМ ENTER)"
echo "  "
echo "  "
sudo subspace-cli init
echo "  "
echo "  "
echo "ПЕРЕНАСТРОЙКА КОНФИГ ФАЙЛА"
sudo chmod +x /root/.config/subspace-cli
sudo sed -i 's/chain = "Gemini3f"/chain = "Gemini3g"/g' /root/.config/subspace-cli/settings.toml
echo "  "
echo "  "
echo "СТАРТ СЕРВИСА"
echo "  "
echo "  "
systemctl enable subspaced.service
systemctl start subspaced.service
echo "  "
echo "  "
echo "СТАТУС СЕРВИСА"
echo "  "
echo "  "
systemctl status subspaced.service
exit

