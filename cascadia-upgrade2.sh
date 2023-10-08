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
sudo curl -L -O https://github.com/CascadiaFoundation/cascadia/releases/download/v0.1.4/cascadiad-v0.1.4-linux-amd64.tar.gz
sudo tar -zxf cascadiad-v0.1.4-linux-amd64.tar.gz
cd bin/
sudo chmod u+x cascadiad
sudo cp cascadiad /usr/local/bin/cascadiad
sudo chown $USER /usr/local/bin/cascadiad
cd $HOME
rm -r bin
rm cascadiad-v0.1.4-linux-amd64.tar.gz
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

