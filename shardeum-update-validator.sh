#!/bin/bash
tput reset 
tput civis 


echo " "
echo "ОБНОВЛЕНИЕ НОДЫ VALIDATOR SHARDEUM"
echo " "

curl -O https://gitlab.com/shardeum/validator/dashboard/-/raw/main/installer.sh && chmod +x installer.sh && ./installer.sh

operator-cli gui start
