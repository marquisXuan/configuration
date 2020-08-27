#!/bin/bash

DOCKER_NETWORK_BRIDGE_NAME=nginx-network
#  容器名称
DOCKER_CONTAINER_NAME=mysql
#  容器版本
DOCKER_CONTAINER_VERSION=8.0.20
#  镜像
DOCKER_IMAGES=$(docker images | grep $DOCKER_CONTAINER_NAME | grep $DOCKER_CONTAINER_VERSION | awk '{print $1}')
#  工作空间
DOCKER_WORKSPACE=/srv/docker/mysql
# 数据目录
MYSQL_DATA=$DOCKER_WORKSPACE/data
# 配置目录
MYSQL_CONF=$DOCKER_WORKSPACE/conf
# 日志目录
MYSQL_LOGS=$DOCKER_WORKSPACE/logs
# 默认密码
MYSQL_PASSWORD=Docker-mysql-123456
#  暴露端口
MYSQL_PORT=33060

# 检查是否有镜像
echo -e "\033[32m 检查是否有镜像: $DOCKER_IMAGES \033[0m"

if [ -z "$DOCKER_IMAGES" ]; then
    echo -e "\033[32m  拉取 $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION 镜像 \033[0m"
    docker pull $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION
    DOCKER_IMAGES=$DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION
fi

if [ -z "$DOCKER_IMAGES" ]; then
    echo -e "\033[32m  $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION 镜像拉取失败,程序即将退出 \033[0m"
    exit
fi

# 判断是否有同名容器
CHECK_CONTAINER_NAME=$(docker ps --format='{{.Names}}' | grep $DOCKER_CONTAINER_NAME)
echo -e "\033[32m 判断是否有同名容器: $CHECK_CONTAINER_NAME \033[0m"

if [ -n "$CHECK_CONTAINER_NAME" ]; then
    echo -e "\033[32m 已存在 $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION 容器 \033[0m"
    exit
fi

# 判断是否有工作空间
echo -e "\033[32m 判断是否有工作空间: $DOCKER_WROKSPACE \033[0m"
if [ -d "$DOCKER_WROKSPACE" ]; then
    echo -e "\033[32m 创建工作空间 \033[0m"
    mkdir -p $MYSQL_DATA $MYSQL_CONF $MYSQL_LOGS
fi

# 判断是否有默认配置文件
echo -e "\033[32m 判断是否有默认配置文件: $MYSQL_CONF/my.conf \033[0m"
if [ -f "$MYSQL_CONF/my.cnf" ]; then
    echo -e "\033[32m 初始化默认配置文件 \033[0m"
    echo "W215c3FsXQpkZWZhdWx0LWNoYXJhY3Rlci1zZXQgPSB1dGY4bWI0CgpbbXlzcWxfc2FmZV0KZGVmYXVsdC1jaGFyYWN0ZXItc2V0ID0gdXRmOG1iNAoKW2NsaWVudF0KZGVmYXVsdC1jaGFyYWN0ZXItc2V0ID0gdXRmOG1iNAoKW215c3FsZF0KcGlkLWZpbGU9L3Zhci9ydW4vbXlzcWxkL215c3FsZC5waWQKc29ja2V0PS92YXIvcnVuL215c3FsZC9teXNxbGQuc29jawpkYXRhZGlyPS92YXIvbGliL215c3FsCnN5bWJvbGljLWxpbmtzPTAKaW5pdF9jb25uZWN0PSdTRVQgTkFNRVMgdXRmOG1iNCcKY2hhcmFjdGVyLXNldC1zZXJ2ZXI9dXRmOG1iNApjb2xsYXRpb24tc2VydmVyPXV0ZjhtYjRfdW5pY29kZV9jaQpkZWZhdWx0X2F1dGhlbnRpY2F0aW9uX3BsdWdpbj1teXNxbF9uYXRpdmVfcGFzc3dvcmQKY2hhcmFjdGVyLXNldC1zZXJ2ZXI9dXRmOG1iNAo=" | base64 -d >$MYSQL_CONF/my.cnf
fi

echo "\033[32m 创建容器 $DOCKER_CONTAINER_NAME \033[0m"

# 创建容器
docker run \
    --network $DOCKER_NETWORK_BRIDGE_NAME \
    -v $MYSQL_LOGS:/logs -v /etc/localtime:/etc/localtime:ro \
    -p $MYSQL_PORT:3306 \
    -v $MYSQL_DATA:/var/lib/mysql \
    -v $MYSQL_CONF:/etc/mysql/conf.d/ \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_PASSWORD \
    --name $DOCKER_CONTAINER_NAME \
    --restart=always \
    -d $DOCKER_CONTAINER_NAME:$DOCKER_CONTAINER_VERSION
