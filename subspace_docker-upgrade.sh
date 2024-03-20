#!/bin/bash
tput reset 
tput civis
echo " "
echo " "
echo "ПЕРЕХОД НА ДИРЕКТОРИЮ SUBSPACE"
echo " "
echo " "
cd $HOME
cd subspace-docker

echo " "
echo " "
echo "ОТКЛЮЧЕНИЕ КОНТЕЙНЕРОВ SUBSPACE"
docker-compose down
sleep 30
echo " "
echo " "

echo " "
echo " "
echo "ОБНОВЛЕНИЕ SUBSPACE"
echo " "
echo " "


OLD_IMAGE_NODE="node:gemini-3h-2024-mar-18"
NEW_IMAGE_NODE="node:gemini-3h-2024-mar-20"
OLD_IMAGE_FARMER="farmer:gemini-3h-2024-mar-18"
NEW_IMAGE_FARMER="farmer:gemini-3h-2024-mar-20"
DOCKER_COMPOSE_FILE="docker-compose.yaml"

# Проверяем, существует ли файл docker-compose.yaml
if [ ! -f "$DOCKER_COMPOSE_FILE" ]; then
    echo "Файл $DOCKER_COMPOSE_FILE не найден."
    exit 1
fi

# Заменяем старый образ на новый в файле docker-compose.yaml
sed -i "s/$OLD_IMAGE_NODE/$NEW_IMAGE_NODE/g" "$DOCKER_COMPOSE_FILE"
sed -i "s/$OLD_IMAGE_FARMER/$NEW_IMAGE_FARMER/g" "$DOCKER_COMPOSE_FILE"
echo "ОБРАЗ УСПЕШНО ЗАМЕНЕН В ФАЙЛЕ $DOCKER_COMPOSE_FILE."



echo " "
echo " "
echo "ВКЛЮЧЕНИЕ КОНТЕЙНЕРОВ SUBSPACE"
echo " "
echo " "
docker-compose pull
sleep 30

echo " "
echo " "
echo "НОДА SUBSPACE ОБНОВЛЕНА"
echo " "
echo " "
docker-compose up -d
sleep 30

echo " "
echo " "
echo "ПРОВЕРКА КОНТЕЙНЕРОВ SUBSPACE"
echo " "
echo " "
docker ps -a

