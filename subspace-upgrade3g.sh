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
wget -O subspace-cli-node "https://github.com/subspace/subspace/releases/download/gemini-3g-2023-nov-29/subspace-node-ubuntu-aarch64-gemini-3g-2023-nov-29"
sleep 15
wget -O subspace-cli-farmer "https://github.com/subspace/subspace/releases/download/gemini-3g-2023-nov-29/subspace-farmer-ubuntu-x86_64-skylake-gemini-3g-2023-nov-29"
sleep 15
sudo chmod +x subspace-cli-node
sudo chmod +x subspace-cli-farmer
sudo mv subspace-cli-node /usr/local/bin/
sudo mv subspace-cli-farmer /usr/local/bin/
cd /usr/local/bin/
echo "  "
echo "  "
echo "ДАЛЕЕ НЕОБХОДИМО ВВЕСТИ АДРЕС КОШЕЛЬКА POLKADOT.JS ИЛИ SUBWALLET И НАЗВАНИЕ НОДЫ. ОСТАЛЬНЫЕ ШАГИ ОСТАВЛЯЕМ ПО УМОЛЧАНИЮ (НАЖИМАЕМ ENTER)"
echo "  "
echo "  "
sudo ./subspace-cli-node init
echo "  "
echo "  "
echo "ПЕРЕНАСТРОЙКА КОНФИГ ФАЙЛА"
sudo chmod +x $HOME/.config/pulsar
sudo chmod +x $HOME/.config/subspace-cli
sudo chmod +x $HOME/.config/subspace-cli-node
sudo sed -i 's/chain = 'gemini-3f'/chain = 'gemini-3g'/g' $HOME/.config/pulsar/settings.toml
sudo ./subspace-cli-farm farm
echo "  "
echo "  "
echo "СТАРТ СЕРВИСА"
echo "  "
echo "  "
systemctl enable subspaced.service
systemctl start subspaced.service
systemctl enable subspaced-farmer.service
systemctl start subspaced-farmer.service
echo "  "
echo "  "
echo "СТАТУС СЕРВИСА"
echo "  "
echo "  "
systemctl status subspaced.service
systemctl status subspaced-farmer.service
exit

