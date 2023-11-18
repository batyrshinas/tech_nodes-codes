#!/bin/bash
tput reset
tput civis

echo "  "
echo "  "

echo "ОСТАНАВЛИВАЕМ СЕРВИС"
echo "  "
echo "  "
sudo systemctl stop cascadiad

echo "  "
echo "  "
echo "ОБНОВЛЕНИЕ БИНАРНИКА"
echo "  "
echo "  "
rm /usr/local/bin/cascadiad
cd $HOME
curl -L https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.8/cascadiad -o cascadiad
#cd bin/
sudo chmod u+x cascadiad
sudo cp cascadiad /usr/local/bin/cascadiad
sudo chown $USER /usr/local/bin/cascadiad
cd $HOME
rm -r bin
echo "  "
echo "  "
echo "СТАРТ СЕРВИСА"
echo "  "
echo "  "
sudo systemctl restart cascadiad
echo "  "
echo "  "
echo "СТАТУС СЕРВИСА"
echo "  "
echo "  "
systemctl status cascadiad
exit

