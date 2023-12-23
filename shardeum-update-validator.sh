#!/bin/bash
tput reset 
tput civis 


echo " "
echo " "
echo "ОБНОВЛЕНИЕ НОДЫ VALIDATOR SHARDEUM"
echo " "
echo " "

curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh
cd $HOME
cd .shardeum
./shell.sh
operator-cli gui start
operator-cli start
operator-cli status
exit

your_server_ip=$(wget -qO- eth0.me)
echo " "
echo " "
echo "******************* ОбНОВЛЕНИЕ НОДЫ ЗАВЕРШЕНА *******************"
echo " "
echo " "
echo " "
echo " "
echo "******************* ПРОВЕРКИ ВЕРСИИ НОДЫ *******************"
echo " "
echo " "
curl $your_server_ip:9001/nodeinfo
echo " "
echo " "
echo "ВАШ ДАШБОРД - https://$your_server_ip:8080"
