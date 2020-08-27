#!/bin/bash

_path=$1
_container_name=$2
_env=$3

DOCKER_IMAGES=$(docker images | grep spring-boot-images | awk '{print $1}')

if [ -z "$DOCKER_IMAGES" ]; then
    __path=/srv/docker/java/base
    mkdir -p $__path && cd $__path
    echo "RlJPTSBvcGVuamRrOjgKRU5WIEpBVkFfT1BUSU9OUz0iIgpFTlRSWVBPSU5UIFsgInNoIiwgIi1jIiwgImphdmEgJEpBVkFfT1BUUyAtRGphdmEuc2VjdXJpdHkuZWdkPWZpbGU6L2Rldi8uL3VyYW5kb20gLWphciAvb3B0L2FwcC5qYXIiIF0K" | base64 -d >$__path/Dockerfile
    DOCKER_IMAGES=spring-boot-images
    docker build -t $DOCKER_IMAGES .
fi

# 基于 docker 的 spring-boot 容器
DOCKER_NETWORK_BRIDGE_NAME=nginx-network

if [ -n "$_path" ]; then
    docker run \
        --network $DOCKER_NETWORK_BRIDGE_NAME \
        -v /etc/localtime:/etc/localtime:ro \
        -v $_path:/opt/app.jar \
        -v /var/logs/java:/var/logs/java \
        --name $_container_name \
        -e JAVA_OPTS=-Dspring.profiles.active=$env \
        --restart=always \
        -d $DOCKER_IMAGES
fi
echo -e "\033[36m 无参时,只创建 SpringBoot 镜像 \033[0m"
