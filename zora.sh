read -p "ВВЕДИТЕ ССЫЛКУ HHTPS ИЗ ALCHEMY: " link_http



sudo apt-get update && sudo apt-get update -y


sudo apt install curl build-essential git screen jq pkg-config libssl-dev libclang-dev ca-certificates gnupg lsb-release -y


sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose -y

git clone https://github.com/conduitxyz/node.git


cd node



./download-config.py zora-mainnet-0


export CONDUIT_NETWORK=zora-mainnet-0

cp .env.example .env




sed -i.bak "s|^OP_NODE_L1_ETH_RPC=.*|OP_NODE_L1_ETH_RPC=$link_http|" .env



docker compose up --build