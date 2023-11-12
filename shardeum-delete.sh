#!/bin/bash
tput reset 
tput civis 

echo " "
echo " "

echo "ПОДТВЕРЖДАЕТЕ УДАЛЕНИЕ НОДЫ STARKNET ИЗ ВАШЕГО СЕРВЕРА?"
echo " "
echo "ЕСЛИ ДА, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «y»"
echo "ЕСЛИ НЕТ, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «n»"
echo "ВВЕДИТЕ ОТВЕТ:"
read item
case "$item" in
    y|Y) echo "ВЫ ВВЕЛИ «y», НАЧИНАЕМ ПРОЦЕСС УДАЛЕНИЯ..."
        ;;
    n|N) echo "ВЫ ВВЕЛИ «n», ПРОЦЕСС УДАЛЕНИЯ ПРЕКРАЩЕН"
        exit 0
        ;;
    *) echo "ВЫ НИЧЕГО НЕ ВВЕЛИ. ВЫХОД..."
         exit 1
        ;;
esac

echo " "
echo " "
echo "УДАЛЕНИЕ  НОДЫ"
echo " "
echo " "

sudo docker stop shardeum-dashboard
sudo docker rm shardeum-dashboard
sudo docker image rm local-dashboard
sudo rm -rf .shardeum

echo " "
echo " "
echo "НОДА УДАЛЕНА"
echo " "
echo " "
exit
echo " "
echo " "