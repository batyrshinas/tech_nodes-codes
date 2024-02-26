#!/bin/bash
tput reset
tput civis

echo " "
echo " "
echo "НАЧИНАЕМ УСТАНОВКУ NWAKU ..."
echo " "
echo " "
echo " "
echo " "
echo "ЗАПРОС ПЕРВИЧНЫХ ДАННЫХ ДЛЯ ЗАПУСКА"
echo " "
echo " "
read -p "ВВЕДИТЕ API KEY:  " ETH_CLIENT_ADDRESS && sleep 2
echo " "
echo " "
read -p "ВВЕДИТЕ PRIVATE KEY КОШЕЛЬКА:  " ETH_TESTNET_KEY && sleep 2
echo " "
echo " "
read -p "ПРИДУМАЙТЕ ПАРОЛЬ ОТ RLN RELAY:  " RLN_RELAY_CRED_PASSWORD && sleep 2
echo " "
echo " "

echo "КЛОНИРОВАНИЕ РЕПОЗИТОРИЯ"
echo " "
echo " "
cd $HOME
git clone https://github.com/waku-org/nwaku-compose
cd nwaku-compose

echo " "
echo " "
echo "НАСТРОЙКА ОКРУЖЕНИЯ"
echo " "
echo " "
cp .env.example .env
#sed -i.bak "s|^ETH_CLIENT_ADDRESS=.*|ETH_CLIENT_ADDRESS=$ETH_CLIENT_ADDRESS|" .env
#sed -i.bak "s|^ETH_TESTNET_KEY=.*|ETH_TESTNET_KEY=$ETH_TESTNET_KEY|" .env
#sed -i.bak "s|^RLN_RELAY_CRED_PASSWORD=.*|RLN_RELAY_CRED_PASSWORD=$RLN_RELAY_CRED_PASSWORD|" .env
sed -i "s/<key>/$ETH_CLIENT_ADDRESS/g" ".env"
sed -i "s/<YOUR_TESTNET_PRIVATE_KEY_HERE>/$ETH_TESTNET_KEY/g" ".env"
sed -i "s/my_secure_keystore_password/$RLN_RELAY_CRED_PASSWORD/g" ".env"
#<key>
#<YOUR_TESTNET_PRIVATE_KEY_HERE>
#my_secure_keystore_password
#touch .env


echo " "
echo " "
echo "РЕГИСТРАЦИЯ RLN И СОХРАНЕНИЕ KEYNOTE"
echo " "
echo " "
./register_rln.sh
echo " "
echo " "
echo "ЗАПУСК DOCKER-COMPOSE"
echo " "
echo " "
docker-compose up -d
echo " "
echo " "
sleep 30
echo "ПРОВЕРКА СОСТОЯНИЯ DOCKER КОНТЕЙНЕРОВ"
echo " "
echo " "
sudo docker ps -a
