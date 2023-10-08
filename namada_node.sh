#!/bin/bash
tput reset
tput civis

if ss -tulpen | awk '{print $5}' | grep -q ":26656$" ; then
  echo -e "УСТАНОВКА НЕВОЗМОЖНА ПОРТ 26656 УЖЕ ЗАНЯТ"
  exit
else
  echo ""
fi

NAMADA_CHAIN_ID="public-testnet-14.5d79b6958580"

if [ ! $VALIDATOR_ALIAS ]; then
	read -p "ВВЕДИТЕ ИМЯ ВАЛИДАТОРА: " VALIDATOR_ALIAS
	echo 'export VALIDATOR_ALIAS='\"${VALIDATOR_ALIAS}\" >> $HOME/.bash_profile
fi

rm -rf $HOME/namada_folder
mkdir -p $HOME/namada_folder
cd $HOME/namada_folder
wget -O namada.tar.gz https://github.com/anoma/namada/releases/download/v0.23.0/namada-v0.23.0-Linux-x86_64.tar.gz 
tar xvf namada.tar.gz
cd namada-*
sudo chmod +x namada namada[c,n,w]
sudo mv namada /usr/local/bin/
sudo mv namada[c,n,w] /usr/local/bin/

cd $HOME
namada client utils join-network --chain-id $NAMADA_CHAIN_ID
sleep 3
echo "[Unit]
Description=Namada Node
After=network.target

[Service]
User=$USER
WorkingDirectory=$HOME/.local/share/namada
Type=simple
ExecStart=/usr/local/bin/namada --base-dir=$HOME/.local/share/namada node ledger run
Environment=NAMADA_CMT_STDOUT=true
RemainAfterExit=no
Restart=always
RestartSec=5s
LimitNOFILE=65535

[Install]
WantedBy=multi-user.target" > $HOME/namadad.service
sudo mv $HOME/namadad.service /etc/systemd/system
sudo tee <<EOF >/dev/null /etc/systemd/journald.conf
Storage=persistent
EOF
echo -e 'ЗАПУСКАЕМ СЕРВИС' && sleep 1
sudo systemctl restart systemd-journald
sudo systemctl daemon-reload
sudo systemctl enable namadad
sudo systemctl restart namadad

echo -e 'ПРОВЕРЯЕМ СТАТУС НОДЫ'

service namadad status
