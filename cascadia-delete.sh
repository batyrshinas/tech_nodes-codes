#!/bin/bash
tput reset
tput civis

echo " "
echo " "

#echo "ПОДТВЕРЖДАЕТЕ УДАЛЕНИЕ НОДЫ CASCADIA ИЗ ВАШЕГО СЕРВЕРА?"
#echo " "
#echo "ЕСЛИ ДА, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «y»"
#echo "ЕСЛИ НЕТ, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «n»"
#echo "ВВЕДИТЕ ОТВЕТ:"
#read item
#case "$item" in
#    y|Y) echo "ВЫ ВВЕЛИ «y», НАЧИНАЕМ ПРОЦЕСС УДАЛЕНИЯ..."
#        ;;
#    n|N) echo "ВЫ ВВЕЛИ «n», ПРОЦЕСС УДАЛЕНИЯ ПРЕКРАЩЕН"
#        exit 0
#        ;;
#    *) echo "ВЫ НИЧЕГО НЕ ВВЕЛИ. ВЫХОД..."
#         exit 1
#        ;;
#esac


echo " "
echo " "
echo "УДАЛЕНИЕ НОДЫ..."
echo " "
echo " "
sudo systemctl stop cascadiad
sudo systemctl disable cascadiad
sudo rm -rf $HOME/.cascadiad
sudo rm -rf $HOME/cascadia
sudo rm -rf /etc/systemd/system/cascadiad.service
sudo rm -rf /usr/local/bin/cascadiad
sudo systemctl daemon-reload
sudo rm //usr/local/bin/cascadia_auto_delegate.sh

echo " "
echo " "
echo "НОДА УДАЛЕНА"
echo " "
echo " "
exit
echo " "
echo " "
