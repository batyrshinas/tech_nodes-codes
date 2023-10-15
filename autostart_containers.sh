#!/bin/bash
tput reset
tput civis

echo " "
echo " "
echo "НАЧИНАЕМ НАСТРОЙКУ АВТОЗАПУСКА КОНТЕЙНЕРОВ DOCKER"
echo " "
echo " "


container_ids=$(docker ps -aq)

for id in $container_ids; do
    docker update --restart always $id
done
echo " "
echo " "
echo "ЗАПУСК DOCKER"
echo " "
echo " "
systemctl enable docker
echo " "
echo " "
echo "ПРОВЕРКА РАБОТОСПОСОБНОСТИ DOCKER" 
systemctl is-enabled docker
echo " "
echo " "
echo "ПРОВЕРКА СТАТУСА DOCKER"
systemctl status docker
echo " "
echo " "
echo "******************* НАСТРОЙКА АВТОЗАПУСКА КОНТЕЙНЕРОВ DOCKER ЗАВЕРШЕНА *******************"

