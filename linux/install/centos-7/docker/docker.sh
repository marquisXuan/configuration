#!/bin/bash

groupDocker=$(cat /etc/group | grep docker | wc -l | awk '{print $0}')

if test $groupDocker -eq 0 ; then
  # docker组 todo 检查用户组是否存在
  groupadd docker -g 7654
else
  echo -e "\033[33m docker 组已存在 \033[33m"  
fi

dockerInstalled=$(yum list installed | grep docker | wc -l | awk '{print $0}')

if test $dockerInstalled -eq 0 ; then 
  # 安装 docker 检查 docker 是否已经安装
  yum -y install docker
else
  echo -e "\033[33m 已安装 Docker \033[33m"
fi

# 修改 docker 软件源
echo "ewoJInJlZ2lzdHJ5LW1pcnJvcnMiOgoJCVsKCQkJImh0dHA6Ly9mMmQ2Y2I0MC5tLmRhb2Nsb3VkLmlvIgoJCQksImh0dHA6Ly9odWItbWlycm9yLmMuMTYzLmNvbSIKCQkJLCJodHRwczovL2RvY2tlci5taXJyb3JzLnVzdGMuZWR1LmNuIgoJCQksImh0dHBzOi8vcmVnaXN0cnkuZG9ja2VyLWNuLmNvbSIKCQldCn0K" | base64 -d >/etc/docker/daemon.json
      
systemctl enable docker && systemctl start docker

# #################### docker 容器安装 ####################

# 网桥配置 定义一个 docker 网桥,名称为 nginx-network
DOCKER_NETWORK_BRIDGE_NAME=nginx-network

DOCKER_NETWORK_BRIDGE=$(docker network ls --filter=name=$DOCKER_NETWORK_BRIDGE_NAME | sed -n '2 ,1p' | awk '{print $2}')
if [ -z "$DOCKER_NETWORK_BRIDGE" ]; then
    echo -e "\033[33m  创建 docker 网桥:[$DOCKER_NETWORK_BRIDGE_NAME] \033[0m"
    docker network create $DOCKER_NETWORK_BRIDGE_NAME
else
  echo -e "\033[33m 网桥:[$DOCKER_NETWORK_BRIDGE_NAME] 已存在\033[33m"
fi
DOCKER_NETWORK_BRIDGE=$(docker network ls --filter=name=$DOCKER_NETWORK_BRIDGE_NAME | sed -n '2 ,1p' | awk '{print $2}')
if [ -z "$DOCKER_NETWORK_BRIDGE" ]; then
    echo -e "\033[33m  网桥创建失败,程序即将退出 \033[0m"
    exit
fi

# 网桥创建成功,可以创建容器了
if [ -f "$PWD/docker-nginx.sh" ]; then
    echo -e "\033[33m 创建 nginx 容器 \033[0m"
    $($PWD/docker-nginx.sh)
fi

if [ -f "$PWD/docker-mysql.sh" ]; then
    echo -e "\033[33m 创建 mysql 容器 \033[0m"
    $($PWD/docker-mysql.sh)
fi
