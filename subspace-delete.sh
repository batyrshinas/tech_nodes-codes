#!/bin/bash
tput reset 
tput civis 

echo " "
echo " "

echo "ПОДТВЕРЖДАЕТЕ УДАЛЕНИЕ НОДЫ SUBSPACE ИЗ ВАШЕГО СЕРВЕРА?"
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
sudo systemctl stop subspaced.service
sudo systemctl disable subspaced.service
sudo rm -v /etc/systemd/system/subspaced.service
sudo systemctl daemon-reload
sudo systemctl stop subspaced subspaced-farmer &>/dev/null
sudo rm -rf ~/.local/share/subspace*
sudo rm /usr/local/bin/subspace-cli
sudo rm -rf $HOME/.config/subspace-cli/
echo " "
echo " "
echo "НОДА УДАЛЕНА"
echo " "
echo " "
exit
echo " "
echo " "
