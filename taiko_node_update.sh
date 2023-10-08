#!/bin/bash
tput reset 
tput civis 


echo " "
echo " "

echo "ПОДТВЕРДИТЕ ОБНОВЛЕНИЕ НОДЫ TAIKO"
echo "ЕСЛИ ОТВЕТ - ДА, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «y»"
echo "ЕСЛИ ОТВЕТ - НЕТ, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «n»"
echo "ВВЕДИТЕ ОТВЕТ:"
read item
case "$item" in
    y|Y) echo "ВЫ ВВЕЛИ «y», ОБНОВЛЯЕМ..."
        ;;
    n|N) echo "ВЫ ВВЕЛИ «n», ОТМЕНЯЕМ..."
        exit 0
        ;;
esac

echo "НАЧИНАЕМ ОБНОВЛЕНИЕ НОДЫ TAIKO..."
cd ~/simple-taiko-node
sudo docker compose pull
cd $HOME

echo " "
echo " "
echo "ОБНОВЛЕНИЕ НОДЫ TAIKO ЗАВЕРШЕНО"
echo " "
echo " "
