#!/bin/bash
tput reset 
tput civis 

echo " "
echo "НАЧИНАЕМ УСТАНОВКУ НОДЫ SUBSPACE"
echo " "
echo "ВЫ ЗАВЕЛИ КРИПТОКОШЕЛЕК SubWallet или Polkadot.js?"
echo "ЕСЛИ ДА, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «y»"
echo "ЕСЛИ НЕТ, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «n»"
echo "ВВЕДИТЕ ОТВЕТ:"
read item
case "$item" in
    y|Y) echo "ВЫ ВВЕЛИ «y», ПРОДОЛЖАЕМ..."
        ;;
    n|N) echo "ВЫ ВВЕЛИ «n», НЕОБХОДИМО ПЕРЕЙТИ НА САЙТ https://subwallet.app/ или https://polkadot.js.org И ЗАВЕСТИ КРИПТОКОКШЕЛЕК SubWallet или Polkadot.js. ЗАТЕМ НЕОБХОДИМО ЗАПУСТИТЬ УСТАНОВКУ НОДЫ ЗАНОВО..."
        exit 0
        ;;
    *) echo "ВЫ НИЧЕГО НЕ ВВЕЛИ. ВЫПОЛНЯЕМ ДЕЙСТВИЕ ПО УМОЛЧАНИЮ..."
        ;;
esac
echo " "
echo " "
echo "ДОБАВЛЕНИЕ НЕОБХОДИМЫХ ПРАВИЛ В ФАЕРВОЛЫ"
sudo ufw allow 30333
sudo ufw allow 30433
sudo ufw allow 30533
sudo iptables -t filter -A INPUT -p tcp --dport 30333 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 30433 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 30533 -j ACCEPT
echo " "
echo " "
echo "УДАЛЕНИЕ СТАРОЙ ВЕРСИИ НОДЫ"
systemctl stop subspaced.service
systemctl disable subspaced.service
sudo rm -v /etc/systemd/system/subspaced.service
sudo systemctl daemon-reload
systemctl stop subspaced subspaced-farmer &>/dev/null
sudo rm -rf ~/.local/share/subspace*
sudo rm /usr/local/bin/subspace-cli
sudo rm -rf $HOME/.config/subspace-cli/
echo " "
echo " "

echo "УСТАНОВКА НЕОБХОДИМОГО ПО"
cd $HOME
sudo apt update && sudo apt upgrade -y
sudo apt install ocl-icd-libopencl1 libgomp1 wget -y
sudo wget -O subspace-cli 'https://github.com/subspace/pulsar/releases/download/v0.6.14-alpha/pulsar-ubuntu-x86_64-skylake-v0.6.14-alpha'
speep 15
sudo chmod +x subspace-cli
sudo mv subspace-cli /usr/local/bin/
sudo rm -rf $HOME/.config/subspace-cli
echo " "
echo " "
echo "НЕОБХОДИМО ВВЕСТИ В СЛЕДУЮЩЕМ ДИАЛОГОВОМ ОКНЕ АДРЕС КРИПТОКОШЕЛЬКА SubWallet или Polkadot.js, ЗАТЕМ ПРИДУМАТЬ УНИКАЛЬНОЕ ИМЯ НОДЫ. ОСТАЛЬНЫЕ ШАГИ МОЖНО ОСТАВИТЬ ПО УМОЛЧАНИЮ (ПРОСТО НАЖИМАЕМ КНОПКУ «Enter»)"
sudo /usr/local/bin/subspace-cli init

#change network
cd $HOME/.config/subspace-cli
file=settings.toml
sed -i 's/chain = "Gemini3d"/chain = "Gemini3e"/g' $file


#source ~/.bash_profile
sleep 5
echo " "
echo " "
echo "СОЗДАНИЕ И ЗАПУСК СЛУЖБЫ ДЛЯ НОДЫ"
echo "[Unit]
Description=Subspace Node
After=network.target

[Service]
User=$USER
Type=simple
ExecStart=/usr/local/bin/subspace-cli farm --verbose
Restart=on-failure
LimitNOFILE=1024000

[Install]
WantedBy=multi-user.target" > $HOME/subspaced.service

sudo mv $HOME/subspaced.service /etc/systemd/system/
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable subspaced
sudo systemctl restart subspaced

echo "==================================================="
echo -e '\n\e[42mCheck node status\e[0m\n' && sleep 5
if [[ `service subspaced status | grep active` =~ "running" ]]; then
  echo -e "Your Subspace node \e[32minstalled and works\e[39m!"
  echo -e "You can check node status by the command \e[7mservice subspaced status\e[0m"
  echo -e "Press \e[7mQ\e[0m for exit from status menu"
else
  echo -e "Your Subspace node \e[31mwas not installed correctly\e[39m, please reinstall."
fi
echo " "
echo " "
echo "НОДА УСТАНОВЛЕНА И ЗАПУЩЕНА"
echo " "
echo " "

