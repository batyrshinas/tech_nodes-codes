#!/bin/bash
tput reset 
tput civis 


echo " "
echo " "

echo "ПОДТВЕРДИТЕ УДАЛЕНИЕ НОДЫ TAIKO"
echo "ЕСЛИ ОТВЕТ - ДА, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «y»"
echo "ЕСЛИ ОТВЕТ - НЕТ, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «n»"
echo "ВВЕДИТЕ ОТВЕТ:"
read item
case "$item" in
    y|Y) echo "ВЫ ВВЕЛИ «y», УДАЛЯЕМ..."
        ;;
    n|N) echo "ВЫ ВВЕЛИ «n», ОТМЕНЯЕМ..."
        exit 0
        ;;
esac

echo "НАЧИНАЕМ УДАЛЕНИЕ НОДЫ TAIKO..."
#remove a node
cd ~/simple-taiko-node
sudo docker compose down -v
sudo rm -f .env
cd $HOME
rm -r ~/simple-taiko-node

echo " "
echo " "
echo "УДАЛЕНИЕ НОДЫ TAIKO ЗАВЕРШЕНО"
echo " "
echo " "
