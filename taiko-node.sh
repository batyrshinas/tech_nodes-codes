#!/bin/bash
tput reset 
tput civis 

 

#all links
link_key_wallet="https://metamask.zendesk.com/hc/en-us/articles/360015289632-How-to-export-an-account-s-private-key"
link_testnets="https://chainlist.org/"
link_infura="https://app.infura.io/"
link_sepolia="https://sepoliafaucet.com/"
link_etherscan="https://sepolia.etherscan.io/"
link_explorer="https://explorer.test.taiko.xyz/"
ip_address=$(sudo wget -qO- eth0.me)
echo " "
echo " "

echo "ВЫ ПОДГОТОВИЛИ ВАШ КРИПТОКОШЕЛЕК METAMASK К РАБОТЕ С НОДОЙ TAIKO?"
echo "ЕСЛИ ОТВЕТ - ДА, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «y»"
echo "ЕСЛИ ОТВЕТ - НЕТ, ТО ВВЕДИТЕ В АНГЛ.РАСКЛАДКЕ БУКВУ «n»"
echo "ВВЕДИТЕ ОТВЕТ:"
read item
case "$item" in
    y|Y) echo "ВЫ ВВЕЛИ «y», ПРОДОЛЖАЕМ..."
        ;;
    n|N) echo "ВЫ ВВЕЛИ «n», НЕОБХОДИМО ПОДГОТОВИТЬ КРИПТОКОШЕЛЕК METAMASK К РАБОТЕ С НОДОЙ TAIKO. ЗАТЕМ НЕОБХОДИМО ЗАПУСТИТЬ УСТАНОВКУ НОДЫ ЗАНОВО..."
        exit 0
        ;;
esac

echo " "
echo " "
echo "ДОБАВЛЕНИЕ НЕОБХОДИМЫХ ПРАВИЛ В ФАЕРВОЛЫ"
echo " "
echo " "
sudo ufw allow 22
sudo ufw allow 8000
sudo ufw allow 8545
sudo ufw allow 8546
sudo ufw allow 6060
sudo ufw allow 30303
sudo ufw allow 9000
sudo ufw allow 9090
sudo ufw allow 3000
sudo iptables -t filter -A INPUT -p tcp --dport 22 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 8000 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 8545 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 8546 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 6060 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 30303 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 9000 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 9090 -j ACCEPT
sudo iptables -t filter -A INPUT -p tcp --dport 3000 -j ACCEPT
echo " "
echo " "

echo "УСТАНОВКА НЕОБХОДИМЫХ ПАКЕТОВ..."
echo " "
echo " "
cd $HOME
sudo apt update && sudo apt upgrade -y
sudo apt install curl wget -y

# Install git
echo "УСТАНОВКА GIT..."
sudo apt update && apt upgrade -y
sudo apt install pkg-config curl git-all build-essential libssl-dev libclang-dev ufw
git version
echo " "
echo " "

# Install docker
echo "УСТАНОВКА DOCKER..."
sudo apt-get install ca-certificates curl gnupg lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo chmod a+r /etc/apt/keyrings/docker.gpg
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

sudo apt install docker-compose

#inslall need packets for docker
sudo snap install docker -y
sudo apt  install podman-docker -y
sudo apt  install docker.io -y
sudo service docker start
sudo apt-get update -y
echo " "
echo " "
echo "ПРОВЕРКА РАБОТОСПОСОБНОСТИ DOCKER..."
echo " "
echo " "
sudo docker run hello-world
echo " "
echo " "
echo "НЕОБХОДИМЫЕ ПАКЕТЫ УСТАНОВЛЕНЫ"
echo " "
echo " "

echo "УДАЛЕНИЕ СТАРОЙ ВЕРСИИ НОДЫ..."
#remove a node
cd ~/simple-taiko-node
sudo docker compose down -v
sudo rm -f .env
cd $HOME
rm -r ~/simple-taiko-node

echo " "
echo " "
echo "УДАЛЕНИЕ СТАРОЙ ВЕРСИИ НОДЫ ЗАВЕРШЕНО"
echo " "
echo " "

echo "НАЧИНАЕМ УСТАНОВКУ НОДЫ TAIKO..."
# Install node
cd $HOME
git clone https://github.com/taikoxyz/simple-taiko-node.git
echo " "
echo " "
# Go to the simple-taiko-node directory
cd simple-taiko-node

# Copy .env.sample to .env file
cp .env.sample .env


# Request user input for key wallet
read -p "ВВЕДИТЕ ВАШ ПРИВАТНЫЙ КЛЮЧ КОШЕЛЬКА METAMASK (КАК НАЙТИ: ГАЙД ПО ССЫЛКЕ $link_key_wallet): " key_wallet
# Request user input for wallet address
read -p "ВВЕДИТЕ ВАШ АДРЕС КОШЕЛЬКА METAMASK: " address_wallet
echo " "
echo "ПЕРЕХОДИМ НА САЙТ INFURA ($link_infura) И ПРОХОДИМ РЕГИСТРАЦИЮ. ДАЛЕЕ ПЕРЕХОДИМ ПО ССЫЛКЕ В ПИСЬМЕ, ЧТОБЫ ПОЛУЧИТЬ ДОСТУП К САЙТУ"
echo " "
echo " "
echo "ДАЛЕЕ НА САЙТЕ $link_infura НАЖИМАЕМ НА CREAET NEW API KEY В СТРОКЕ NETWORK* ВЫБИРАЕМ WEB3 API И В СТРОКЕ NAME* ПРИДУМЫВАЕМ НАЗВАНИЕ ПРОЕКТА"
echo " "
echo " "
echo "ДАЛЕЕ КЛИКАЕМ ВКЛАДКУ API KEYS И НАЖИМАЕМ НА НАЗВАНИЕ ВАШЕГО СОЗДАННОГО ПРОЕКТА"
echo " "
echo " "
echo "ДАЛЕЕ ПЕРЕХОДИМ НА ВКЛАДКУ ENDPOINTS И МЕНЯЕМ СЕТЬ ДЛЯ ETHERIUM С MAINNET НА SEPOLIA"
echo " "
echo " "
echo "ДАЛЕЕ КОПИРУЕМ HTTPS КЛЮЧ, КОТОРЫЙ ВЫСВЕТИТСЯ В СТРОКЕ И МЕНЯЕМ ВКЛАДКУ HTTPS НА WEBSOCKET, СКОПИРОВАВ ПРИ ЭТОМ НАШ ВТОРОЙ КЛЮЧ WEBSOCKET"
echo " "
echo " "
# Request user input for HTTP link
read -p "ВВЕДИТЕ ССЫЛКУ HHTPS: " link_http

# Request user input for WS link
read -p "ВВЕДИТЕ ССЫЛКУ WEBSOCKETS: " link_ws


#sed -i 's/^L2_SUGGESTED_FEE_RECIPIENT.*$/L2_SUGGESTED_FEE_RECIPIENT='$address_wallet'/' .env

sed -i 's/^DISABLE_P2P_SYNC.*$/DISABLE_P2P_SYNC=true/' .env

# Replace ENABLE_PROPOSER value from "false" to "true"
sed -i 's/^ENABLE_PROVER.*$/ENABLE_PROVER=true/' .env

sed -i 's/^ENABLE_PROPOSER.*$/ENABLE_PROPOSER=true/' .env

# Replace PRIVATE_KEY value with key_wallet
sed -i.bak "s|^L1_PROVER_PRIVATE_KEY=.*|L1_PROVER_PRIVATE_KEY=$key_wallet|" .env

# Replace FEE_RECIPIENT value with address
sed -i.bak "s|^L2_SUGGESTED_FEE_RECIPIENT=.*|L2_SUGGESTED_FEE_RECIPIENT=$address_wallet|" .env

# Replace L1_ENDPOINT_HTTP value with key_wallet
sed -i.bak "s|^L1_ENDPOINT_HTTP=.*|L1_ENDPOINT_HTTP=$link_http|" .env

# Replace L1_ENDPOINT_WS value with link_ws
sed -i.bak "s|^L1_ENDPOINT_WS=.*|L1_ENDPOINT_WS=$link_ws|" .env

sed -i.bak "s|^L1_PROPOSER_PRIVATE_KEY=.*|L1_PROPOSER_PRIVATE_KEY=$key_wallet|" .env

echo " "
echo " "
#Запуск ноды
echo "ЗАПУСК НОДЫ"
echo " "
echo " "
cd ~/simple-taiko-node
docker compose up -d
echo " "
echo " "
echo "ПОСМОТРЕТЬ ТРАНЗАКЦИИ НОДЫ МОЖНО ПО ССЫЛКЕ: $link_etherscan ИЛИ $link_explorer"
echo " "
echo " "
echo "ПОСМОТРЕТЬ РАБОТОСПОСОБНОСТЬ НОДЫ МОЖНО ПО ССЫЛКЕ: http://$ip_address:3000/d/L2ExecutionEngine/l2-execution-engine-overview?orgId=1&from=now-30m&to=now&refresh=10s"
echo " "
echo " "
echo " "
echo " "
echo "ТАКЖЕ ПРОВЕРИТЬ РАБОТОСПОСОБНОСТЬ МОЖНО НА САЙТЕ INFURA ($link_infura) ВО ВКЛАДКЕ API KEYS ВЫБРАВ НАЗВАНИЕ СВОЕГО ПРОЕКТА И НАЖАВ КНОПКУ VIEW STATS "
echo " "
echo " "
