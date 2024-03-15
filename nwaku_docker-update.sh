#!/bin/bash
tput reset 
tput civis
echo " "
echo " "
echo "ПЕРЕХОД НА ДИРЕКТОРИЮ NWAKU"
echo " "
echo " "
cd $HOME
cd nwaku-compose

echo " "
echo " "
echo "ОТКЛЮЧЕНИЕ КОНТЕЙНЕРОВ NWAKU"
docker-compose down
sleep 30
echo " "
echo " "

echo " "
echo " "
echo "ОБНОВЛЕНИЕ NWAKU"
echo " "
echo " "


OLD_IMAGE="nwaku:v0.25.0"
NEW_IMAGE="nwaku:v0.26.0"
DOCKER_COMPOSE_FILE="docker-compose.yml"

# Проверяем, существует ли файл docker-compose.yaml
if [ ! -f "$DOCKER_COMPOSE_FILE" ]; then
    echo "Файл $DOCKER_COMPOSE_FILE не найден."
    exit 1
fi

# Заменяем старый образ на новый в файле docker-compose.yaml
sed -i "s/$OLD_IMAGE/$NEW_IMAGE/g" "$DOCKER_COMPOSE_FILE"
echo "ОБРАЗ УСПЕШНО ЗАМЕНЕН В ФАЙЛЕ $DOCKER_COMPOSE_FILE."



echo " "
echo " "
echo "ВКЛЮЧЕНИЕ КОНТЕЙНЕРОВ NWAKU"
echo " "
echo " "
docker-compose pull
sleep 30

echo " "
echo " "
echo "НОДА NWAKU ОБНОВЛЕНА"
echo " "
echo " "
docker-compose up -d
sleep 30

echo " "
echo " "
echo "ПРОВЕРКА КОНТЕЙНЕРОВ NWAKU"
echo " "
echo " "
docker ps -a
