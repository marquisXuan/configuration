#!/bin/bash

DOCKER_NETWORK_BRIDGE_NAME=nginx-network
# 容器名称
DOCKER_CONTAINER_NAME=nginx
# 容器版本
DOCKER_CONTAINER_VERSION=1.17.9
# 镜像
DOCKER_IMAGES=$(docker images | grep $DOCKER_CONTAINER_NAME | grep $DOCKER_CONTAINER_VERSION | awk '{print $1}')
# 工作空间
DOCKER_WROKSPACE=/srv/docker/nginx
# 配置文件目录
NGINX_WORKSPACE_CONF=$DOCKER_WROKSPACE/conf
# 文件服务器
NGINX_WORKSPACE_FILES=$DOCKER_WROKSPACE/files
# 静态网站
NGINX_WORKSPACE_WEB=$DOCKER_WROKSPACE/www
# 日志文件目录
NGINX_WORKSPACE_LOGS=$DOCKER_WROKSPACE/logs

# 检查是否有镜像
echo -e "\033[33m 检查是否有镜像: $DOCKER_IMAGES \033[0m"
if [ -z "$DOCKER_IMAGES" ]; then
    echo -e "\033[33m  拉取 $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION 镜像 \033[0m"
    docker pull $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION
    DOCKER_IMAGES=$DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION
fi
if [ -z "$DOCKER_IMAGES" ]; then
    echo -e "\033[33m  $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION 镜像拉取失败,程序即将退出 \033[0m"
    exit
fi

# 判断是否有工作空间
echo -e "\033[33m 判断是否有工作空间: $DOCKER_WROKSPACE \033[0m"
if [ ! -d "$DOCKER_WROKSPACE" ]; then
    echo -e "\033[33m 创建工作空间 \033[0m"
    mkdir -p $NGINX_WORKSPACE_CONF $NGINX_WORKSPACE_FILES $NGINX_WORKSPACE_WEB $NGINX_WORKSPACE_LOGS
fi

# 判断是否有默认配置文件
echo -e "\033[33m 判断是否有默认配置文件: $NGINX_WORKSPACE_CONF/nginx.conf \033[0m"
if [ ! -f "$NGINX_WORKSPACE_CONF/nginx.conf" ]; then
    echo -e "\033[33m 初始化默认配置文件 \033[0m"
    # 写配置文件,默认的
    echo "IyDkuIDoiKzkuIDkuKrov5vnqIvotrPlpJ/kuoYs5aaC5p6c5pyJU1NM44CBZ3ppcOi/meS6m+avlOi+g+a2iOiAl0NQVeeahOW3peS9nO+8jOiAjOS4lOaYr+WkmuaguENQVeeahOivne+8jOWPr+S7peiuvuS4uuWSjENQVeeahOaVsOmHj+S4gOagtwojIHdvcmtlcl9wcm9jZXNzZXMgNDsKCmV2ZW50cyB7Cgl1c2UgZXBvbGw7Cgl3b3JrZXJfY29ubmVjdGlvbnMgMTAyNDsKCWFjY2VwdF9tdXRleCBvbjsKCW11bHRpX2FjY2VwdCBvbjsKfQoKaHR0cCB7CglzZXJ2ZXJfdG9rZW5zIG9mZjsKCWluY2x1ZGUgbWltZS50eXBlczsKCWRlZmF1bHRfdHlwZSBhcHBsaWNhdGlvbi9vY3RldC1zdHJlYW07CglhY2Nlc3NfbG9nIC9ldGMvbmdpbngvbG9ncy9hY2Nlc3MubG9nOwoJZXJyb3JfbG9nIC9ldGMvbmdpbngvbG9ncy9lcnJvci5sb2c7CgoJY2xpZW50X21heF9ib2R5X3NpemUgMTAyNE07CglzZW5kZmlsZSBvbjsKCgljbGllbnRfaGVhZGVyX2J1ZmZlcl9zaXplIDIwazsKCWxhcmdlX2NsaWVudF9oZWFkZXJfYnVmZmVycyA4IDQwazsKCWluY2x1ZGUgL2V0Yy9uZ2lueC9zZXJ2ZXJzLyouY29uZjsKfQo=" | base64 -d >$NGINX_WORKSPACE_CONF/nginx.conf
fi

# 判断是否有同名容器
CHECK_CONTAINER_NAME=$(docker ps --format='{{.Names}}' | grep $DOCKER_CONTAINER_NAME)
echo -e "\033[33m 判断是否有同名容器: $CHECK_CONTAINER_NAME \033[0m"

if [ -z "$CHECK_CONTAINER_NAME" ]; then
    echo -e "\033[33m 创建容器 $DOCKER_CONTAINER_NAME \033[0m"
    # 创建容器
    docker run \
        --name $DOCKER_CONTAINER_NAME \
        --network $DOCKER_NETWORK_BRIDGE_NAME \
        -p 80:80 \
        -p 443:443 \
        -v $NGINX_WORKSPACE_CONF:/etc/nginx/conf.d \
        -v $NGINX_WORKSPACE_CONF/nginx.conf:/etc/nginx/nginx.conf \
        -v $NGINX_WORKSPACE_CONF/servers:/etc/nginx/servers \
        -v $NGINX_WORKSPACE_FILES:/etc/nginx/file \
        -v $NGINX_WORKSPACE_WEB:/etc/nginx/www \
        -v $NGINX_WORKSPACE_LOGS:/etc/nginx/logs \
        -v /etc/localtime:/etc/localtime:ro \
        --restart=always -d $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION
fi
